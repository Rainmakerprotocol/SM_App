import 'dart:async';
import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/auth/application/auth_controller.dart';
import '../offline_providers.dart';
import '../offline_status.dart';
import 'punch_sync_transport.dart';

/// SyncManager drives the Phase 1-1 §2.2 blueprint: it watches for
/// foreground/network/manual triggers, drains the Drift queue in small
/// batches, posts to `/api/mobile/punches/batch`, and applies jittered
/// exponential backoff when the server or network rejects a batch.
class SyncManager {
  SyncManager({
    required this.queueDao,
    required this.punchesDao,
    required Ref ref,
    required this.transport,
    this.maxBatchSize = 25,
    this.maxAttempts = 5,
    Duration? initialBackoff,
    Duration? maxBackoff,
  }) : _ref = ref,
       _initialBackoff = initialBackoff ?? const Duration(seconds: 5),
       _maxBackoff = maxBackoff ?? const Duration(minutes: 5);

  final SyncQueueDao queueDao;
  final PunchesDao punchesDao;
  final Ref _ref;
  final PunchSyncTransport transport;
  final int maxBatchSize;
  final int maxAttempts;
  final Duration _initialBackoff;
  final Duration _maxBackoff;

  SyncState _state = SyncState.idle;
  Duration _currentBackoff = Duration.zero;
  Timer? _timer;

  SyncState get state => _state;

  Future<void> dispose() async {
    _timer?.cancel();
    _timer = null;
  }

  Future<void> trigger(SyncTrigger trigger) async {
    if (_state == SyncState.running) {
      return;
    }

    final status = _ref.read(offlineStatusProvider);
    if (!status.hasConnectivity) {
      _scheduleRetry();
      return;
    }

    await _runSync(trigger);
  }

  Future<void> _runSync(SyncTrigger trigger) async {
    _state = SyncState.running;
    final session = _ref.read(authSessionProvider);
    if (session == null) {
      _state = SyncState.idle;
      return;
    }

    try {
      var entries = await _nextBatch();
      while (entries.isNotEmpty) {
        final payloads = entries
            .map(
              (entry) => PunchPayload(queueId: entry.id, data: entry.payload),
            )
            .toList();
        final response = await transport.send(
          session: session,
          payloads: payloads,
        );
        await _handleResponse(entries, response);
        entries = await _nextBatch();
      }
      if (_state != SyncState.backingOff) {
        _state = SyncState.idle;
        _currentBackoff = Duration.zero;
      }
    } on PunchSyncTransportException catch (e) {
      _handleTransportException(e);
    } catch (_) {
      _scheduleRetry();
    }
  }

  Future<List<QueuedPayload>> _nextBatch() async {
    return queueDao.fetchPending(limit: maxBatchSize);
  }

  Future<void> _handleResponse(
    List<QueuedPayload> batch,
    PunchSyncResponse response,
  ) async {
    final uuidToEntry = {
      for (final entry in batch) entry.mobileUuid ?? 'queue-${entry.id}': entry,
    };

    final processedIds = <int>{};
    final syncedPunchIds = <String>{};

    for (final uuid in response.processed) {
      final entry = uuidToEntry[uuid];
      if (entry != null) {
        processedIds.add(entry.id);
        _collectSyncedId(entry, syncedPunchIds);
      }
    }

    for (final uuid in response.duplicates) {
      final entry = uuidToEntry[uuid];
      if (entry != null) {
        processedIds.add(entry.id);
        _collectSyncedId(entry, syncedPunchIds);
      }
    }

    if (processedIds.isNotEmpty) {
      await queueDao.deleteEntries(processedIds.toList());
    }

    if (syncedPunchIds.isNotEmpty) {
      await _markPunchesSynced(syncedPunchIds);
    }

    if (response.hasErrors) {
      await _handleErrors(response.errors, batch);
    }
  }

  Future<void> _handleErrors(
    List<PunchSyncError> errors,
    List<QueuedPayload> batch,
  ) async {
    final batchByUuid = {
      for (final entry in batch) entry.mobileUuid ?? 'queue-${entry.id}': entry,
    };

    for (final error in errors) {
      final entry = batchByUuid[error.uuid];
      if (entry == null) {
        continue;
      }

      switch (error.code) {
        case 'duplicate':
          await queueDao.deleteEntries([entry.id]);
          if (entry.mobileUuid != null) {
            await _markPunchesSynced({entry.mobileUuid!});
          }
          break;
        case 'invalid_job':
        case 'invalid_timestamp':
        case 'job_mismatch':
          await _handleConflictFailure(entry, error);
          break;
        case 'validation_error':
          await _handleTerminalFailure(entry, error);
          break;
        default:
          await _handleRetryableFailure(entry, error.code);
          break;
      }
    }
  }

  Future<void> _handleRetryableFailure(QueuedPayload entry, String code) async {
    if (entry.attemptCount + 1 >= maxAttempts) {
      await queueDao.deleteEntries([entry.id]);
      if (entry.mobileUuid != null) {
        await punchesDao.markError(entry.mobileUuid!, errorCode: code);
      }
      return;
    }
    await queueDao.recordAttempt(entry.id, error: code);
    _scheduleRetry();
  }

  Future<void> _handleTerminalFailure(
    QueuedPayload entry,
    PunchSyncError error,
  ) async {
    await queueDao.deleteEntries([entry.id]);
    if (entry.mobileUuid != null) {
      await punchesDao.markError(
        entry.mobileUuid!,
        errorCode: error.code,
        errorMessage: error.message,
      );
    }
    // TODO: surface analytics hook for permanently dropped payloads.
  }

  Future<void> _handleConflictFailure(
    QueuedPayload entry,
    PunchSyncError error,
  ) async {
    await queueDao.deleteEntries([entry.id]);
    if (entry.mobileUuid != null) {
      await punchesDao.markError(
        entry.mobileUuid!,
        errorCode: error.code,
        errorMessage: error.message,
        requiresDispute: true,
      );
    }
  }

  void _handleTransportException(PunchSyncTransportException exception) {
    switch (exception.code) {
      case 'unauthorized':
        _state = SyncState.paused;
        break;
      case 'server_error':
      case 'validation_error':
      default:
        _scheduleRetry();
        break;
    }
  }

  void _scheduleRetry() {
    if (_timer?.isActive ?? false) {
      return;
    }

    _currentBackoff = _nextBackoff();
    _timer = Timer(_currentBackoff, () => trigger(SyncTrigger.periodic));
    _state = SyncState.backingOff;
  }

  Duration _nextBackoff() {
    if (_currentBackoff == Duration.zero) {
      return _initialBackoff;
    }
    final next = _currentBackoff * 2;
    final jitter = Random().nextDouble() * _initialBackoff.inMilliseconds;
    final result = Duration(milliseconds: next.inMilliseconds + jitter.toInt());
    return result > _maxBackoff ? _maxBackoff : result;
  }

  void _collectSyncedId(QueuedPayload entry, Set<String> accumulator) {
    final uuid = entry.mobileUuid;
    if (entry.entityType != 'punch' || uuid == null) {
      return;
    }
    accumulator.add(uuid);
  }

  Future<void> _markPunchesSynced(Iterable<String> punchIds) async {
    for (final punchId in punchIds) {
      await punchesDao.markSynced(punchId);
    }
  }
}

enum SyncTrigger { explicit, foreground, networkReconnect, periodic }

enum SyncState { idle, running, backingOff, paused }

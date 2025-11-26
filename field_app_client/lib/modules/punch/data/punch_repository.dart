import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../offline/database/app_database.dart';
import '../../../offline/offline_providers.dart';
import '../domain/punch_models.dart';

typedef Clock = DateTime Function();

import 'package:field_app_client/modules/timesheet/domain/timesheet_rebuild_engine.dart';

final punchRepositoryProvider = Provider<PunchRepository>((ref) {
  return PunchRepository(
    punchesDao: ref.watch(punchesDaoProvider),
    syncQueueDao: ref.watch(syncQueueDaoProvider),
    rebuildEngine: ref.watch(timesheetRebuildEngineProvider),
    clock: () => DateTime.now(),
  );
});

final pendingPunchCountProvider = StreamProvider<int>((ref) {
  final repository = ref.watch(punchRepositoryProvider);
  return repository.watchPendingCount();
});

final pendingPunchStatsProvider = StreamProvider<PendingPunchStats>((ref) {
  final repository = ref.watch(punchRepositoryProvider);
  return repository.watchPendingStats();
});

class PunchRepository {
  PunchRepository({
    required this.punchesDao,
    required this.syncQueueDao,
    required this.rebuildEngine,
    required Clock clock,
    Uuid? uuid,
  }) : _clock = clock,
       _uuid = uuid ?? const Uuid();

  final PunchesDao punchesDao;
  final SyncQueueDao syncQueueDao;
  final TimesheetRebuildEngine rebuildEngine;
  final Clock _clock;
  final Uuid _uuid;

  Future<String> recordPunch(PunchDraft draft) async {
    final punchId = draft.punchId ?? _uuid.v4();
    final now = _clock();

    final entry = PunchesLocalCompanion(
      punchId: Value(punchId),
      employeeId: Value(draft.employeeId),
      jobId: Value(draft.jobId),
      serviceId: Value(draft.serviceId),
      punchType: Value(draft.type.storageValue),
      timestampDevice: Value(draft.timestamp),
      gpsLat: Value(draft.gps?.lat),
      gpsLng: Value(draft.gps?.lng),
      gpsAccuracy: Value(draft.gps?.accuracy),
      gpsUnavailable: Value(draft.gpsUnavailable),
      synced: const Value(false),
      syncAttempts: const Value(0),
      requiresDispute: const Value(false),
      source: Value(draft.source),
      deviceId: Value(draft.deviceId),
      lastError: const Value(null),
      createdAt: Value(now),
      updatedAt: Value(now),
    );

    await punchesDao.upsert(entry);

    final payload = draft.toPayload(punchId);
    // NOTE(DL-005): Payload mirrors the assumed `/api/mobile/punches/batch`
    // contract; backend can request additional fields (job item, cost code,
    // etc.) without changing call sites because everything flows through this
    // serialization step.
      payload: payload,
    );

    // Trigger timesheet rebuild
    rebuildEngine.triggerRebuild(
      employeeId: draft.employeeId,
      date: draft.timestamp,
      source: 'punch_recorded',
    );

    return punchId;
  }

  Stream<int> watchPendingCount() => punchesDao.watchPendingCount();

  Stream<PendingPunchStats> watchPendingStats() {
    return punchesDao.watchPendingSnapshot().map(
      (snapshot) => PendingPunchStats(
        count: snapshot.count,
        oldestTimestamp: snapshot.oldestTimestamp,
      ),
    );
  }
}

class PendingPunchStats {
  const PendingPunchStats({required this.count, this.oldestTimestamp});

  static const PendingPunchStats empty = PendingPunchStats(count: 0);

  final int count;
  final DateTime? oldestTimestamp;

  Duration? oldestAge({DateTime? reference}) {
    final anchor = reference ?? DateTime.now();
    if (oldestTimestamp == null) {
      return null;
    }
    return anchor.difference(oldestTimestamp!);
  }
}

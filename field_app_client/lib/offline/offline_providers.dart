import 'dart:async';
import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final punchesDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PunchesDao(db);
});

class PunchesDao {
  const PunchesDao(this._db);
  final AppDatabase _db;

  Future<List<PunchesLocalData>> pending() => _db.getPendingPunches();

  Future<void> upsert(PunchesLocalCompanion entry) => _db.upsertPunch(entry);

  Future<int> pendingCount() => _db.countPendingPunches();

  Stream<int> watchPendingCount() => _db.watchPendingPunchCount();

  Future<void> markSynced(String punchId) => _db.markPunchSynced(punchId);

  Stream<PendingPunchSnapshot> watchPendingSnapshot() =>
      _db.watchPendingPunchSnapshot();

  Future<void> markError(
    String punchId, {
    required String errorCode,
    String? errorMessage,
    bool requiresDispute = false,
  }) => _db.recordPunchError(
    punchId,
    errorCode: errorCode,
    errorMessage: errorMessage,
    requiresDispute: requiresDispute,
    markSynced: requiresDispute,
  );
}

final jobsDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return JobsDao(db);
});

class JobsDao {
  const JobsDao(this._db);
  final AppDatabase _db;

  Future<void> upsert(JobsLocalCompanion entry) => _db.upsertJob(entry);

  Future<void> upsertMany(List<JobsLocalCompanion> entries) =>
      _db.upsertJobs(entries);

  Future<void> upsertFeedState(JobFeedStateLocalCompanion entry) =>
      _db.upsertJobFeedState(entry);

  Future<JobFeedStateLocalData?> feedState(String employeeId) =>
      _db.jobFeedState(employeeId);

  Stream<JobFeedStateLocalData?> watchFeedState(String employeeId) =>
      _db.watchJobFeedState(employeeId);

  Future<List<JobsLocalData>> window({
    required DateTime start,
    required DateTime end,
  }) => _db.jobsForWindow(start: start, end: end);

  Stream<List<JobsLocalData>> watchWindow({
    required DateTime start,
    required DateTime end,
  }) => _db.watchJobsForWindow(start: start, end: end);
}

final profileDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return ProfileDao(db);
});

class ProfileDao {
  const ProfileDao(this._db);
  final AppDatabase _db;

  Future<void> upsert(ProfileLocalCompanion entry) => _db.upsertProfile(entry);
}

final syncQueueDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return SyncQueueDao(db);
});

class SyncQueueDao {
  const SyncQueueDao(this._db);
  final AppDatabase _db;

  Future<void> enqueuePunchPayload({
    required String mobileUuid,
    required Map<String, dynamic> payload,
  }) async {
    await _db.enqueuePayload(
      SyncQueueCompanion.insert(
        entityType: 'punch',
        payload: jsonEncode(payload),
        mobileUuid: Value(mobileUuid),
      ),
      mode: InsertMode.insertOrIgnore,
    );
  }

  Future<bool> isPunchQueued(String mobileUuid) =>
      _db.hasQueueEntry(entityType: 'punch', mobileUuid: mobileUuid);

  Future<List<QueuedPayload>> fetchPending({
    int limit = 20,
    void Function()? onCorrupt,
  }) async {
    final rows = await _db.oldestQueueItems(limit: limit);
    final payloads = <QueuedPayload>[];
    for (final row in rows) {
      try {
        final decoded = jsonDecode(row.payload) as Map<String, dynamic>;
        payloads.add(
          QueuedPayload(
            id: row.id,
            entityType: row.entityType,
            attemptCount: row.attemptCount,
            payload: decoded,
            queueMobileUuid: row.mobileUuid,
          ),
        );
      } catch (error) {
        await _db.archiveCorruptQueueRow(row, error.toString());
        onCorrupt?.call();
      }
    }
    return payloads;
  }

  Future<void> deleteEntries(List<int> ids) async {
    for (final id in ids) {
      await _db.deleteQueueItem(id);
    }
  }

  Future<void> recordAttempt(int id, {String? error}) async {
    await _db.incrementQueueAttempt(id, error: error);
  }
}

class QueuedPayload {
  const QueuedPayload({
    required this.id,
    required this.entityType,
    required this.attemptCount,
    required this.payload,
    this.queueMobileUuid,
  });

  final int id;
  final String entityType;
  final int attemptCount;
  final Map<String, dynamic> payload;
  final String? queueMobileUuid;

  String? get mobileUuid =>
      queueMobileUuid ?? payload['mobile_uuid'] as String?;
}

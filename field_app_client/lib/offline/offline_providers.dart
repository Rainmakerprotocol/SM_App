import 'dart:convert';

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
}

final jobsDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return JobsDao(db);
});

class JobsDao {
  const JobsDao(this._db);
  final AppDatabase _db;

  Future<void> upsert(JobsLocalCompanion entry) => _db.upsertJob(entry);
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

  Future<int> enqueue(SyncQueueCompanion entry) => _db.enqueuePayload(entry);
  Future<List<QueuedPayload>> fetchPending({int limit = 20}) async {
    final rows = await _db.oldestQueueItems(limit: limit);
    return rows
        .map(
          (row) => QueuedPayload(
            id: row.id,
            entityType: row.entityType,
            attemptCount: row.attemptCount,
            payload: jsonDecode(row.payload) as Map<String, dynamic>,
          ),
        )
        .toList();
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
  });

  final int id;
  final String entityType;
  final int attemptCount;
  final Map<String, dynamic> payload;

  String? get mobileUuid => payload['mobile_uuid'] as String?;
}

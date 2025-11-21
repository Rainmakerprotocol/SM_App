import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'database/app_database.dart';

final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final punchesDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return _PunchesDao(db);
});

class _PunchesDao {
  const _PunchesDao(this._db);
  final AppDatabase _db;

  Future<List<PunchesLocalData>> pending() => _db.getPendingPunches();

  Future<void> upsert(PunchesLocalCompanion entry) => _db.upsertPunch(entry);
}

final jobsDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return _JobsDao(db);
});

class _JobsDao {
  const _JobsDao(this._db);
  final AppDatabase _db;

  Future<void> upsert(JobsLocalCompanion entry) => _db.upsertJob(entry);
}

final profileDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return _ProfileDao(db);
});

class _ProfileDao {
  const _ProfileDao(this._db);
  final AppDatabase _db;

  Future<void> upsert(ProfileLocalCompanion entry) => _db.upsertProfile(entry);
}

final syncQueueDaoProvider = Provider((ref) {
  final db = ref.watch(appDatabaseProvider);
  return _SyncQueueDao(db);
});

class _SyncQueueDao {
  const _SyncQueueDao(this._db);
  final AppDatabase _db;

  Future<int> enqueue(SyncQueueCompanion entry) => _db.enqueuePayload(entry);
  Future<List<SyncQueueData>> oldest({int limit = 20}) => _db.oldestQueueItems(limit: limit);
  Future<int> increment(int id, {String? error}) => _db.incrementQueueAttempt(id, error: error);
  Future<int> remove(int id) => _db.deleteQueueItem(id);
}

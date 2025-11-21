import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'app_database.g.dart';

class PunchesLocal extends Table {
  TextColumn get punchId => text()();
  TextColumn get employeeId => text()();
  TextColumn get jobId => text()();
  TextColumn get serviceId => text().nullable()();
  TextColumn get punchType => text()();
  DateTimeColumn get timestampDevice => dateTime()();
  RealColumn get gpsLat => real().nullable()();
  RealColumn get gpsLng => real().nullable()();
  RealColumn get gpsAccuracy => real().nullable()();
  BoolColumn get gpsUnavailable => boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  IntColumn get syncAttempts => integer().withDefault(const Constant(0))();
  TextColumn get source => text().withDefault(const Constant('mobile_app'))();
  TextColumn get deviceId => text().nullable()();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {punchId};

}

class JobsLocal extends Table {
  TextColumn get jobId => text()();
  TextColumn get code => text()();
  TextColumn get description => text()();
  TextColumn get location => text().nullable()();
  TextColumn get foremanId => text().nullable()();
  IntColumn get crewSize => integer().nullable()();
  DateTimeColumn get windowStart => dateTime().nullable()();
  DateTimeColumn get windowEnd => dateTime().nullable()();
  BoolColumn get hasOpenItems => boolean().withDefault(const Constant(false))();
  DateTimeColumn get updatedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {jobId};
}

class ProfileLocal extends Table {
  TextColumn get employeeId => text()();
  TextColumn get displayName => text()();
  TextColumn get email => text().nullable()();
  TextColumn get phone => text().nullable()();
  TextColumn get crew => text().nullable()();
  TextColumn get role => text().nullable()();
  TextColumn get deviceId => text().nullable()();
  TextColumn get osVersion => text().nullable()();
  DateTimeColumn get lastSync => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {employeeId};
}

class SyncQueue extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get entityType => text()();
  TextColumn get payload => text()();
  IntColumn get attemptCount => integer().withDefault(const Constant(0))();
  TextColumn get lastError => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get lastAttemptAt => dateTime().nullable()();
}

@DriftDatabase(
  tables: [PunchesLocal, JobsLocal, ProfileLocal, SyncQueue],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  Future<void> reset() async {
    await batch((batch) {
      batch.deleteAll(punchesLocal);
      batch.deleteAll(jobsLocal);
      batch.deleteAll(profileLocal);
      batch.deleteAll(syncQueue);
    });
  }

  Future<List<PunchesLocalData>> getPendingPunches() {
    return (select(punchesLocal)..where((tbl) => tbl.synced.equals(false))).get();
  }

  Future<void> upsertPunch(PunchesLocalCompanion entry) {
    return into(punchesLocal).insertOnConflictUpdate(entry);
  }

  Future<void> markPunchSynced(String punchId) async {
    await (update(punchesLocal)..where((tbl) => tbl.punchId.equals(punchId))).write(
      const PunchesLocalCompanion(
        synced: Value(true),
        syncAttempts: Value(0),
        lastError: Value<String?>(null),
      ),
    );
  }

  Future<List<SyncQueueData>> oldestQueueItems({int limit = 20}) {
    final query = (select(syncQueue)
          ..orderBy([
            (tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc),
          ])
          ..limit(limit));
    return query.get();
  }

  Future<int> enqueuePayload(SyncQueueCompanion entry) {
    return into(syncQueue).insert(entry);
  }

  Future<int> incrementQueueAttempt(int id, {String? error}) async {
    final row = await (select(syncQueue)..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
    if (row == null) {
      return 0;
    }

    return (update(syncQueue)..where((tbl) => tbl.id.equals(id))).write(
      SyncQueueCompanion(
        attemptCount: Value(row.attemptCount + 1),
        lastAttemptAt: Value(DateTime.now()),
        lastError: Value(error),
      ),
    );
  }

  Future<int> deleteQueueItem(int id) {
    return (delete(syncQueue)..where((tbl) => tbl.id.equals(id))).go();
  }

  Future<void> upsertJob(JobsLocalCompanion entry) {
    return into(jobsLocal).insertOnConflictUpdate(entry);
  }

  Future<void> upsertProfile(ProfileLocalCompanion entry) {
    return into(profileLocal).insertOnConflictUpdate(entry);
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'storm_master.db'));
    return NativeDatabase.createInBackground(file);
  });
}

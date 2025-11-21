import 'dart:async';
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
  BoolColumn get gpsUnavailable =>
      boolean().withDefault(const Constant(false))();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();
  IntColumn get syncAttempts => integer().withDefault(const Constant(0))();
  TextColumn get source => text().withDefault(const Constant('mobile_app'))();
  TextColumn get deviceId => text().nullable()();
  TextColumn get lastError => text().nullable()();
  BoolColumn get requiresDispute =>
      boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get updatedAt => dateTime().withDefault(currentDateAndTime)();

  @override
  Set<Column> get primaryKey => {punchId};
}

class JobsLocal extends Table {
  TextColumn get jobId => text()();
  TextColumn get serviceId => text()();
  TextColumn get customerName => text()();
  TextColumn get address => text().nullable()();
  DateTimeColumn get scheduledDate => dateTime()();
  TextColumn get foremanId => text().nullable()();
  TextColumn get crewListJson => text().withDefault(const Constant('[]'))();
  TextColumn get crewHash => text().nullable()();
  DateTimeColumn get lastUpdated =>
      dateTime().withDefault(currentDateAndTime)();
  BoolColumn get synced => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {jobId};
}

class JobFeedStateLocal extends Table {
  TextColumn get employeeId => text()();
  DateTimeColumn get rangeStart => dateTime().nullable()();
  DateTimeColumn get rangeEnd => dateTime().nullable()();
  DateTimeColumn get lastRefreshed =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get apiVersion => text().nullable()();
  TextColumn get nextCursor => text().nullable()();

  @override
  Set<Column> get primaryKey => {employeeId};
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
  TextColumn get mobileUuid => text().nullable()();

  @override
  List<Set<Column>> get uniqueKeys => [
    {entityType, mobileUuid},
  ];
}

class CorruptQueueEntries extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get originalQueueId => integer().nullable()();
  TextColumn get entityType => text().nullable()();
  TextColumn get payload => text().nullable()();
  TextColumn get error => text().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

@DriftDatabase(
  tables: [
    PunchesLocal,
    JobsLocal,
    JobFeedStateLocal,
    ProfileLocal,
    SyncQueue,
    CorruptQueueEntries,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 6;

  @override
  MigrationStrategy get migration => MigrationStrategy(
    onCreate: (migrator) async {
      await migrator.createAll();
      await _ensureJobsLocalIndexes();
    },
    onUpgrade: (migrator, from, to) async {
      if (from < 2) {
        await migrator.addColumn(punchesLocal, punchesLocal.requiresDispute);
      }
      if (from < 3) {
        await migrator.addColumn(
          syncQueue,
          syncQueue.mobileUuid as GeneratedColumn,
        );
      }
      if (from < 4) {
        await migrator.createTable(corruptQueueEntries);
      }
      if (from < 5) {
        await customStatement('DROP TABLE IF EXISTS jobs_local');
        await migrator.createTable(jobsLocal);
        await _ensureJobsLocalIndexes();
      }
      if (from < 6) {
        await migrator.createTable(jobFeedStateLocal);
      }
    },
  );

  Future<void> reset() async {
    await batch((batch) {
      batch.deleteAll(punchesLocal);
      batch.deleteAll(jobsLocal);
      batch.deleteAll(jobFeedStateLocal);
      batch.deleteAll(profileLocal);
      batch.deleteAll(syncQueue);
    });
  }

  Future<List<PunchesLocalData>> getPendingPunches() {
    return (select(
      punchesLocal,
    )..where((tbl) => tbl.synced.equals(false))).get();
  }

  Future<void> upsertPunch(PunchesLocalCompanion entry) {
    return into(punchesLocal).insertOnConflictUpdate(entry);
  }

  Future<int> countPendingPunches() async {
    final countExpression = punchesLocal.punchId.count();
    final query = selectOnly(punchesLocal)
      ..addColumns([countExpression])
      ..where(punchesLocal.synced.equals(false));
    final row = await query.getSingle();
    return row.read(countExpression) ?? 0;
  }

  Stream<int> watchPendingPunchCount() {
    final countExpression = punchesLocal.punchId.count();
    final query = selectOnly(punchesLocal)
      ..addColumns([countExpression])
      ..where(punchesLocal.synced.equals(false));
    return query.watchSingle().map((row) => row.read(countExpression) ?? 0);
  }

  Future<void> markPunchSynced(String punchId) async {
    await (update(
      punchesLocal,
    )..where((tbl) => tbl.punchId.equals(punchId))).write(
      PunchesLocalCompanion(
        synced: const Value(true),
        syncAttempts: const Value(0),
        lastError: const Value<String?>(null),
        requiresDispute: const Value(false),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Stream<PendingPunchSnapshot> watchPendingPunchSnapshot() {
    final countExpression = punchesLocal.punchId.count();
    final oldestExpression = punchesLocal.timestampDevice.min();
    final query = selectOnly(punchesLocal)
      ..addColumns([countExpression, oldestExpression])
      ..where(punchesLocal.synced.equals(false));
    return query.watchSingle().map((row) {
      final count = row.read(countExpression) ?? 0;
      final oldest = row.read(oldestExpression);
      return PendingPunchSnapshot(count: count, oldestTimestamp: oldest);
    });
  }

  Future<void> recordPunchError(
    String punchId, {
    required String errorCode,
    String? errorMessage,
    bool requiresDispute = false,
    bool markSynced = false,
  }) async {
    final resolved = errorMessage == null
        ? errorCode
        : '$errorCode: $errorMessage';
    await (update(
      punchesLocal,
    )..where((tbl) => tbl.punchId.equals(punchId))).write(
      PunchesLocalCompanion(
        lastError: Value(resolved),
        requiresDispute: requiresDispute
            ? const Value(true)
            : const Value.absent(),
        synced: markSynced ? const Value(true) : const Value.absent(),
        syncAttempts: const Value(0),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> flagPunchForDispute(
    String punchId, {
    required String errorCode,
    String? errorMessage,
  }) {
    return recordPunchError(
      punchId,
      errorCode: errorCode,
      errorMessage: errorMessage,
      requiresDispute: true,
      markSynced: true,
    );
  }

  Future<List<SyncQueueData>> oldestQueueItems({int limit = 20}) {
    final query = (select(syncQueue)
      ..orderBy([
        (tbl) =>
            OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc),
      ])
      ..limit(limit));
    return query.get();
  }

  Future<int> enqueuePayload(
    SyncQueueCompanion entry, {
    InsertMode mode = InsertMode.insert,
  }) {
    return into(syncQueue).insert(entry, mode: mode);
  }

  Future<void> archiveCorruptQueueRow(SyncQueueData row, String error) async {
    await batch((batch) {
      batch.insert(
        corruptQueueEntries,
        CorruptQueueEntriesCompanion.insert(
          originalQueueId: Value(row.id),
          entityType: Value(row.entityType),
          payload: Value(row.payload),
          error: Value(error),
        ),
      );
      batch.deleteWhere(syncQueue, (tbl) => tbl.id.equals(row.id));
    });
  }

  Future<int> incrementQueueAttempt(int id, {String? error}) async {
    final row = await (select(
      syncQueue,
    )..where((tbl) => tbl.id.equals(id))).getSingleOrNull();
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

  Future<bool> hasQueueEntry({
    required String entityType,
    required String mobileUuid,
  }) async {
    final query = select(syncQueue)
      ..where(
        (tbl) =>
            tbl.entityType.equals(entityType) &
            tbl.mobileUuid.equals(mobileUuid),
      )
      ..limit(1);
    final result = await query.getSingleOrNull();
    return result != null;
  }

  Future<void> upsertJob(JobsLocalCompanion entry) {
    return into(jobsLocal).insertOnConflictUpdate(entry);
  }

  Future<void> upsertJobs(List<JobsLocalCompanion> entries) async {
    if (entries.isEmpty) {
      return;
    }
    await batch((batch) {
      batch.insertAllOnConflictUpdate(jobsLocal, entries);
    });
  }

  Future<void> upsertJobFeedState(JobFeedStateLocalCompanion entry) {
    return into(jobFeedStateLocal).insertOnConflictUpdate(entry);
  }

  Future<JobFeedStateLocalData?> jobFeedState(String employeeId) {
    return (select(jobFeedStateLocal)
          ..where((tbl) => tbl.employeeId.equals(employeeId))
          ..limit(1))
        .getSingleOrNull();
  }

  Stream<JobFeedStateLocalData?> watchJobFeedState(String employeeId) {
    return (select(jobFeedStateLocal)
          ..where((tbl) => tbl.employeeId.equals(employeeId))
          ..limit(1))
        .watchSingleOrNull();
  }

  Future<List<JobsLocalData>> jobsForWindow({
    required DateTime start,
    required DateTime end,
  }) {
    final query = (select(jobsLocal)
      ..where((tbl) => tbl.scheduledDate.isBetweenValues(start, end))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.scheduledDate)]));
    return query.get();
  }

  Stream<List<JobsLocalData>> watchJobsForWindow({
    required DateTime start,
    required DateTime end,
  }) {
    final query = (select(jobsLocal)
      ..where((tbl) => tbl.scheduledDate.isBetweenValues(start, end))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.scheduledDate)]));
    return query.watch();
  }

  Future<void> upsertProfile(ProfileLocalCompanion entry) {
    return into(profileLocal).insertOnConflictUpdate(entry);
  }

  Future<void> _ensureJobsLocalIndexes() async {
    await customStatement(
      'CREATE INDEX IF NOT EXISTS jobs_local_scheduled_date_idx ON jobs_local (scheduled_date)',
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'storm_master.db'));
    // TODO(DL-004): Swap this plaintext driver with SQLCipher/FFI encryption
    // once Security finalizes the at-rest policy. The repository layer already
    // treats the database as opaque so dropping in a new executor is safe.
    return NativeDatabase.createInBackground(file);
  });
}

class PendingPunchSnapshot {
  const PendingPunchSnapshot({required this.count, this.oldestTimestamp});

  final int count;
  final DateTime? oldestTimestamp;
}

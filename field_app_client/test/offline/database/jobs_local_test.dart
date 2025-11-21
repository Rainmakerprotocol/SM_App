import 'package:drift/drift.dart' show Value;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_app_client/offline/database/app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await db.close();
  });

  test('upsertJob persists schema fields and defaults', () async {
    final scheduled = DateTime.utc(2025, 11, 21, 12);
    await db.upsertJob(
      JobsLocalCompanion.insert(
        jobId: 'job-1',
        serviceId: 'svc-1',
        customerName: 'Marigold Solar',
        address: const Value('123 Solar Rd'),
        scheduledDate: scheduled,
        foremanId: const Value('foreman-7'),
        crewListJson: const Value('[{"id":"emp-1"}]'),
        crewHash: const Value('hash-a'),
        synced: const Value(true),
      ),
    );

    final stored = await (db.select(
      db.jobsLocal,
    )..where((tbl) => tbl.jobId.equals('job-1'))).getSingle();

    expect(stored.customerName, 'Marigold Solar');
    expect(stored.address, '123 Solar Rd');
    expect(stored.scheduledDate.isAtSameMomentAs(scheduled), isTrue);
    expect(stored.synced, isTrue);
    expect(stored.crewHash, 'hash-a');
    expect(stored.crewListJson, '[{"id":"emp-1"}]');
  });

  test(
    'jobsForWindow orders by scheduled date and updates crew hash',
    () async {
      final base = DateTime.utc(2025, 11, 21, 8);
      await db.upsertJob(
        JobsLocalCompanion.insert(
          jobId: 'job-2',
          serviceId: 'svc-1',
          customerName: 'Northwind Solar',
          address: const Value('42 Arc St'),
          scheduledDate: base.add(const Duration(days: 1)),
          foremanId: const Value('foreman-2'),
          crewListJson: const Value('[{"id":"emp-9"}]'),
          crewHash: const Value('hash-b'),
        ),
      );
      await db.upsertJob(
        JobsLocalCompanion.insert(
          jobId: 'job-1',
          serviceId: 'svc-1',
          customerName: 'Marigold Solar',
          address: const Value('123 Solar Rd'),
          scheduledDate: base,
          foremanId: const Value('foreman-7'),
          crewListJson: const Value('[{"id":"emp-1"}]'),
          crewHash: const Value('hash-a'),
        ),
      );

      final initial = await db.jobsForWindow(
        start: base.subtract(const Duration(hours: 1)),
        end: base.add(const Duration(days: 2)),
      );

      expect(initial.map((job) => job.jobId), ['job-1', 'job-2']);

      await db.upsertJob(
        JobsLocalCompanion(
          jobId: const Value('job-1'),
          serviceId: const Value('svc-1'),
          customerName: const Value('Marigold Solar'),
          address: const Value('123 Solar Rd'),
          scheduledDate: Value(base),
          foremanId: const Value('foreman-7'),
          crewListJson: const Value('[{"id":"emp-1"},{"id":"emp-2"}]'),
          crewHash: const Value('hash-updated'),
          lastUpdated: Value(base.add(const Duration(minutes: 30))),
          synced: const Value(false),
        ),
      );

      final updated = await db.jobsForWindow(
        start: base.subtract(const Duration(hours: 1)),
        end: base.add(const Duration(days: 2)),
      );

      expect(updated.first.jobId, 'job-1');
      expect(updated.first.crewHash, 'hash-updated');
      expect(updated.first.crewListJson.contains('emp-2'), isTrue);
    },
  );

  test('watchJobsForWindow reflects inserts and updates', () async {
    final windowStart = DateTime.utc(2025, 11, 21);
    final windowEnd = windowStart.add(const Duration(days: 1));

    final initial = await db
        .watchJobsForWindow(start: windowStart, end: windowEnd)
        .first;
    expect(initial, isEmpty);

    await db.upsertJob(
      JobsLocalCompanion.insert(
        jobId: 'job-watch',
        serviceId: 'svc-2',
        customerName: 'Skyline Roofing',
        address: const Value('400 Ridge Rd'),
        scheduledDate: windowStart.add(const Duration(hours: 4)),
        foremanId: const Value('foreman-4'),
        crewListJson: const Value('[{"id":"emp-4"}]'),
        crewHash: const Value('hash-watch-1'),
      ),
    );

    final afterInsert = await db
        .watchJobsForWindow(start: windowStart, end: windowEnd)
        .firstWhere((rows) => rows.isNotEmpty);
    expect(afterInsert.single.jobId, 'job-watch');

    await db.upsertJob(
      JobsLocalCompanion(
        jobId: const Value('job-watch'),
        serviceId: const Value('svc-2'),
        customerName: const Value('Skyline Roofing'),
        address: const Value('400 Ridge Rd'),
        scheduledDate: Value(windowStart.add(const Duration(hours: 4))),
        foremanId: const Value('foreman-4'),
        crewListJson: const Value('[{"id":"emp-4"},{"id":"emp-8"}]'),
        crewHash: const Value('hash-watch-2'),
        lastUpdated: Value(windowStart.add(const Duration(hours: 5))),
        synced: const Value(false),
      ),
    );

    final afterUpdate = await db
        .watchJobsForWindow(start: windowStart, end: windowEnd)
        .firstWhere(
          (rows) => rows.isNotEmpty && rows.first.crewHash == 'hash-watch-2',
        );
    expect(afterUpdate.first.crewListJson.contains('emp-8'), isTrue);
  });
}

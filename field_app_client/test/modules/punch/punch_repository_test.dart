import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_app_client/offline/database/app_database.dart';
import 'package:field_app_client/offline/offline_providers.dart';
import 'package:field_app_client/modules/punch/data/punch_repository.dart';
import 'package:field_app_client/modules/punch/domain/punch_models.dart';

void main() {
  late AppDatabase db;
  late PunchRepository repository;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    repository = PunchRepository(
      punchesDao: PunchesDao(db),
      syncQueueDao: SyncQueueDao(db),
      clock: () => DateTime(2025, 11, 21, 12),
    );
  });

  tearDown(() async {
    await db.close();
  });

  PunchDraft draft({String id = 'demo-id', DateTime? timestamp}) {
    return PunchDraft(
      punchId: id,
      employeeId: '12',
      jobId: '245',
      serviceId: '611',
      type: PunchEventType.punchIn,
      timestamp: timestamp ?? DateTime(2025, 11, 21, 8),
      gps: const PunchGpsSample(lat: 43.0, lng: -83.0, accuracy: 10.0),
      deviceId: 'device-1',
    );
  }

  test('recordPunch stores punch locally and enqueues payload', () async {
    final savedId = await repository.recordPunch(draft());
    expect(savedId, 'demo-id');

    final punches = await db.getPendingPunches();
    expect(punches, hasLength(1));
    final row = punches.first;
    expect(row.jobId, '245');
    expect(row.gpsLat, closeTo(43.0, 0.001));

    final queueRows = await db.oldestQueueItems(limit: 10);
    expect(queueRows, hasLength(1));
    final payload = jsonDecode(queueRows.first.payload) as Map<String, dynamic>;
    expect(payload['mobile_uuid'], 'demo-id');
    expect(payload['job_id'], '245');
  });

  test('watchPendingCount emits updates when punches change', () async {
    final emissions = <int>[];
    final sub = repository.watchPendingCount().listen(emissions.add);

    await Future<void>.delayed(const Duration(milliseconds: 10));
    await repository.recordPunch(draft(id: 'demo-2'));
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(emissions.isNotEmpty, isTrue);
    expect(emissions.last, 1);
    await sub.cancel();
  });

  test('watchPendingStats emits count and oldest timestamp', () async {
    final stats = <PendingPunchStats>[];
    final sub = repository.watchPendingStats().listen(stats.add);

    await Future<void>.delayed(const Duration(milliseconds: 10));
    await repository.recordPunch(
      draft(id: 'old', timestamp: DateTime(2025, 11, 21, 7, 0)),
    );
    await repository.recordPunch(
      draft(id: 'new', timestamp: DateTime(2025, 11, 21, 9, 30)),
    );
    await Future<void>.delayed(const Duration(milliseconds: 10));

    expect(stats.isNotEmpty, isTrue);
    final latest = stats.last;
    expect(latest.count, 2);
    expect(latest.oldestTimestamp, DateTime(2025, 11, 21, 7, 0));
    await sub.cancel();
  });

  test('recordPunch skips enqueue when punch already pending', () async {
    await repository.recordPunch(draft(id: 'dup-1'));
    await repository.recordPunch(draft(id: 'dup-1'));

    final queueRows = await db.oldestQueueItems(limit: 10);
    expect(queueRows, hasLength(1));
    final payload = jsonDecode(queueRows.first.payload) as Map<String, dynamic>;
    expect(payload['mobile_uuid'], 'dup-1');
  });
}

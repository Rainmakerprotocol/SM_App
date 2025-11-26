import 'package:drift/native.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_aggregator.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_rebuild_engine.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockTimesheetAggregator extends Mock implements TimesheetAggregator {}

void main() {
  late AppDatabase db;
  late MockTimesheetAggregator aggregator;
  late TimesheetRebuildEngine engine;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    aggregator = MockTimesheetAggregator();
    engine = TimesheetRebuildEngine(db: db, aggregator: aggregator);
    
    when(() => aggregator.aggregateWeek(any(), any())).thenAnswer((_) async {});
  });

  tearDown(() async {
    engine.dispose();
    await db.close();
  });

  test('triggerRebuild calls aggregator after debounce', () async {
    final date = DateTime(2025, 11, 26);
    final weekStart = DateTime(2025, 11, 24); // Monday

    engine.triggerRebuild(
      employeeId: '12',
      date: date,
      source: 'test',
    );

    // Should not be called immediately due to debounce
    verifyNever(() => aggregator.aggregateWeek(any(), any()));

    // Wait for debounce
    await Future.delayed(const Duration(seconds: 3));

    verify(() => aggregator.aggregateWeek('12', weekStart)).called(1);
  });

  test('multiple triggers are debounced to single execution', () async {
    final date = DateTime(2025, 11, 26);
    
    engine.triggerRebuild(employeeId: '12', date: date, source: '1');
    await Future.delayed(const Duration(milliseconds: 500));
    engine.triggerRebuild(employeeId: '12', date: date, source: '2');
    await Future.delayed(const Duration(milliseconds: 500));
    engine.triggerRebuild(employeeId: '12', date: date, source: '3');

    // Wait for debounce
    await Future.delayed(const Duration(seconds: 3));

    verify(() => aggregator.aggregateWeek('12', any())).called(1);
  });

  test('rebuild updates sync state', () async {
    final date = DateTime(2025, 11, 26);
    final weekStart = DateTime(2025, 11, 24);

    engine.triggerRebuild(employeeId: '12', date: date, source: 'test');
    await Future.delayed(const Duration(seconds: 3));

    final state = await db.select(db.syncStateLocal).getSingle();
    expect(state.key, '12_${weekStart.toIso8601String()}');
    expect(state.status, 'synced');
    expect(state.lastRebuildAt, isNotNull);
  });
}

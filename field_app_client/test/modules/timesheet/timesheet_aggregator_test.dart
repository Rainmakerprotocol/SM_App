import 'package:flutter_test/flutter_test.dart';
import 'package:drift/native.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:field_app_client/offline/offline_providers.dart';
import 'package:field_app_client/modules/timesheet/data/timesheet_repository.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_aggregator.dart';
import 'package:drift/drift.dart';

void main() {
  late AppDatabase db;
  late PunchesDao punchesDao;
  late TimesheetRepository timesheetRepository;
  late TimesheetAggregator aggregator;

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    punchesDao = PunchesDao(db);
    timesheetRepository = TimesheetRepository(db);
    aggregator = TimesheetAggregator(
      punchesDao: punchesDao,
      timesheetRepository: timesheetRepository,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('aggregateWeek calculates daily hours correctly', () async {
    final employeeId = '123';
    final weekStart = DateTime(2023, 10, 23); // Monday

    // Insert punches
    await db.upsertPunch(PunchesLocalCompanion.insert(
      punchId: '1',
      employeeId: employeeId,
      jobId: 'JOB1',
      punchType: 'IN',
      timestampDevice: DateTime(2023, 10, 23, 8, 0), // Mon 8:00
    ));
    await db.upsertPunch(PunchesLocalCompanion.insert(
      punchId: '2',
      employeeId: employeeId,
      jobId: 'JOB1',
      punchType: 'OUT',
      timestampDevice: DateTime(2023, 10, 23, 12, 0), // Mon 12:00 (4 hours)
    ));
    await db.upsertPunch(PunchesLocalCompanion.insert(
      punchId: '3',
      employeeId: employeeId,
      jobId: 'JOB1',
      punchType: 'IN',
      timestampDevice: DateTime(2023, 10, 23, 13, 0), // Mon 13:00
    ));
    await db.upsertPunch(PunchesLocalCompanion.insert(
      punchId: '4',
      employeeId: employeeId,
      jobId: 'JOB1',
      punchType: 'OUT',
      timestampDevice: DateTime(2023, 10, 23, 17, 0), // Mon 17:00 (4 hours)
    ));
    // Total Mon: 8 hours

    await aggregator.aggregateWeek(employeeId, weekStart);

    final timesheets = await db.getTimesheetsForWeek(employeeId, weekStart);
    expect(timesheets.length, 7);
    
    final monday = timesheets.firstWhere((t) => t.date.day == 23);
    expect(monday.regularHours, 8.0);
    expect(monday.otHours, 0.0);
    expect(monday.weeklyTotalHours, 8.0);
  });
}

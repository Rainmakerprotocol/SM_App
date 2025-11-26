import 'package:drift/drift.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_rebuild_engine.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../offline/database/app_database.dart';
import '../../../offline/offline_providers.dart';

class TimesheetRepository {
  final AppDatabase _db;
  final TimesheetRebuildEngine _rebuildEngine;

  TimesheetRepository({
    required AppDatabase db,
    required TimesheetRebuildEngine rebuildEngine,
  })  : _db = db,
        _rebuildEngine = rebuildEngine;

  Future<void> saveTimesheet(TimesheetLocalCompanion timesheet) {
    return _db.upsertTimesheet(timesheet);
  }

  Future<List<TimesheetLocalData>> getTimesheetsForWeek(String employeeId, DateTime weekStart) {
    return _db.getTimesheetsForWeek(employeeId, weekStart);
  }

  Stream<List<TimesheetLocalData>> watchTimesheetsForWeek(String employeeId, DateTime weekStart) {
    return _db.watchTimesheetsForWeek(employeeId, weekStart);
  }

  Stream<List<TimesheetFlagsLocalData>> watchTimesheetFlags(String employeeId, DateTime weekStart) {
    final weekEnd = weekStart.add(const Duration(days: 6));
    return (_db.select(_db.timesheetFlagsLocal)
          ..where((tbl) => tbl.employeeId.equals(employeeId) & tbl.date.isBetweenValues(weekStart, weekEnd))
          ..orderBy([(tbl) => OrderingTerm(expression: tbl.date)]))
        .watch();
  }

  Future<void> refreshTimesheet(String employeeId, DateTime weekStart) async {
    _rebuildEngine.triggerRebuild(
      employeeId: employeeId, 
      date: weekStart, 
      source: 'manual_refresh',
    );
  }
}

final timesheetRepositoryProvider = Provider<TimesheetRepository>((ref) {
  return TimesheetRepository(
    db: ref.watch(appDatabaseProvider),
    rebuildEngine: ref.watch(timesheetRebuildEngineProvider),
  );
});

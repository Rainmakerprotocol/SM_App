import 'dart:async';

import 'package:drift/drift.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_aggregator.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_validator.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:field_app_client/offline/offline_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rxdart/rxdart.dart';

final timesheetRebuildEngineProvider = Provider<TimesheetRebuildEngine>((ref) {
  return TimesheetRebuildEngine(
    db: ref.watch(appDatabaseProvider),
    aggregator: ref.watch(timesheetAggregatorProvider),
  );
});

class TimesheetRebuildEngine {
  TimesheetRebuildEngine({
    required AppDatabase db,
    required TimesheetAggregator aggregator,
  })  : _db = db,
        _aggregator = aggregator {
    _init();
  }

  final AppDatabase _db;
  final TimesheetAggregator _aggregator;
  
  // Debounce subject for rebuild requests
  final _rebuildSubject = PublishSubject<RebuildRequest>();
  late final StreamSubscription _subscription;

  void _init() {
    // Debounce rebuilds to prevent thrashing during bulk syncs
    _subscription = _rebuildSubject
        .debounceTime(const Duration(seconds: 2))
        .listen(_executeRebuild);
  }

  void dispose() {
    _subscription.cancel();
    _rebuildSubject.close();
  }

  /// Trigger a rebuild for a specific week
  void triggerRebuild({
    required String employeeId,
    required DateTime date,
    required String source,
  }) {
    // Normalize to week start (Monday)
    final weekStart = _getWeekStart(date);
    _rebuildSubject.add(RebuildRequest(employeeId, weekStart, source));
  }

  DateTime _getWeekStart(DateTime date) {
    // Assuming Monday is start of week
    return date.subtract(Duration(days: date.weekday - 1));
  }

  Future<void> _executeRebuild(RebuildRequest request) async {
    print('Rebuilding timesheet for ${request.employeeId} week of ${request.weekStart} (Source: ${request.source})');
    
    try {
      // 1. Run Aggregation
      await _aggregator.aggregateWeek(request.employeeId, request.weekStart);

      // 2. Run Validation
      await _runValidation(request.employeeId, request.weekStart);

      // 3. Update Rollups (Cache)
      await _updateRollup(request.employeeId, request.weekStart);

      // 4. Update Sync State
      await _updateSyncState(request.employeeId, request.weekStart);
      
    } catch (e, stack) {
      print('Error rebuilding timesheet: $e');
      // TODO: Log error to crash reporting
    }
  }

  Future<void> _runValidation(String employeeId, DateTime weekStart) async {
    final weekEnd = weekStart.add(const Duration(days: 6));
    
    // Fetch all punches for the week
    final punches = await _db.getPunchesForWindow(
      employeeId, 
      weekStart, 
      weekEnd.add(const Duration(days: 1)).subtract(const Duration(milliseconds: 1)),
    );

    // Group by day
    final punchesByDay = <DateTime, List<PunchesLocalData>>{};
    for (final punch in punches) {
      final date = DateTime(punch.timestampDevice.year, punch.timestampDevice.month, punch.timestampDevice.day);
      punchesByDay.putIfAbsent(date, () => []).add(punch);
    }

    // Clear existing flags for this week (simple approach: delete and recreate)
    // In a real app, we might want to be smarter to preserve 'resolved' status
    await (_db.delete(_db.timesheetFlagsLocal)
      ..where((tbl) => tbl.employeeId.equals(employeeId) & tbl.date.isBetweenValues(weekStart, weekEnd)))
      .go();

    // Validate each day
    final allFlags = <TimesheetFlagsLocalCompanion>[];
    for (final entry in punchesByDay.entries) {
      final flags = TimesheetValidator.validateDay(
        employeeId: employeeId,
        date: entry.key,
        punches: entry.value,
      );
      allFlags.addAll(flags);
    }

    // Batch insert flags
    if (allFlags.isNotEmpty) {
      await _db.batch((batch) {
        batch.insertAll(_db.timesheetFlagsLocal, allFlags);
      });
    }
  }

  Future<void> _updateRollup(String employeeId, DateTime weekStart) async {
    // Calculate totals from TimesheetLocal
    final timesheets = await _db.getTimesheetsForWeek(employeeId, weekStart);
    
    double totalHours = 0;
    double regularHours = 0;
    double otHours = 0;

    for (final ts in timesheets) {
      totalHours += ts.regularHours + ts.otHours;
      regularHours += ts.regularHours;
      otHours += ts.otHours;
    }

    // Create a simple hash of the values (for change detection)
    final hash = '${totalHours.toStringAsFixed(2)}|${regularHours.toStringAsFixed(2)}|${otHours.toStringAsFixed(2)}';

    await _db.into(_db.timesheetRollupsLocal).insertOnConflictUpdate(
      TimesheetRollupsLocalCompanion(
        employeeId: Value(employeeId),
        weekStart: Value(weekStart),
        totalHours: Value(totalHours),
        regularHours: Value(regularHours),
        otHours: Value(otHours),
        hash: Value(hash),
        lastCalculatedAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> _updateSyncState(String employeeId, DateTime weekStart) async {
    final key = '${employeeId}_${weekStart.toIso8601String()}';
    await _db.into(_db.syncStateLocal).insertOnConflictUpdate(
      SyncStateLocalCompanion(
        key: Value(key),
        lastRebuildAt: Value(DateTime.now()),
        status: const Value('synced'), // Local rebuild complete
      ),
    );
  }
}

class RebuildRequest {
  final String employeeId;
  final DateTime weekStart;
  final String source;

  RebuildRequest(this.employeeId, this.weekStart, this.source);
}

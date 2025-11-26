import 'package:collection/collection.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../offline/database/app_database.dart';
import '../../../offline/offline_providers.dart';
import '../data/timesheet_repository.dart';

final timesheetAggregatorProvider = Provider<TimesheetAggregator>((ref) {
  return TimesheetAggregator(
    db: ref.watch(appDatabaseProvider),
    punchesDao: ref.watch(punchesDaoProvider),
  );
});

class TimesheetAggregator {
  final AppDatabase db;
  final PunchesDao punchesDao;

  TimesheetAggregator({
    required this.db,
    required this.punchesDao,
  });

  Future<void> aggregateWeek(String employeeId, DateTime weekStart) async {
    // Ensure weekStart is at midnight
    final start = DateTime(weekStart.year, weekStart.month, weekStart.day);
    final end = start.add(const Duration(days: 7));
    
    final punches = await punchesDao.getForWindow(employeeId, start, end);

    // Group by day
    final punchesByDay = groupBy(punches, (p) {
      final date = p.timestampDevice;
      return DateTime(date.year, date.month, date.day);
    });

    final List<TimesheetLocalCompanion> daysToSave = [];
    double weeklyTotalHours = 0;
    double weeklyOtHours = 0;

    // Calculate daily totals
    for (int i = 0; i < 7; i++) {
      final date = start.add(Duration(days: i));
      final dayPunches = punchesByDay[date] ?? [];
      
      // Sort by time to be safe
      dayPunches.sort((a, b) => a.timestampDevice.compareTo(b.timestampDevice));
      
      final stats = _calculateDailyStats(dayPunches);
      
      weeklyTotalHours += stats.regularHours + stats.otHours;
      weeklyOtHours += stats.otHours;

      daysToSave.add(TimesheetLocalCompanion.insert(
        timesheetId: '${employeeId}_${date.toIso8601String().substring(0, 10)}',
        employeeId: employeeId,
        weekStart: start,
        weekEnd: end,
        date: date,
        regularHours: stats.regularHours,
        otHours: stats.otHours,
        weeklyTotalHours: 0, // Placeholder
        weeklyOt1Hours: 0, // Placeholder
        estimatedPay: 0, // Placeholder
        synced: const Value(false),
        updatedAt: Value(DateTime.now()),
      ));
    }
    
    // Mock pay rate for now (should come from ProfileLocal)
    const double hourlyRate = 25.0;
    final estimatedPay = (weeklyTotalHours - weeklyOtHours) * hourlyRate + (weeklyOtHours * hourlyRate * 1.5);

    // Update weekly totals and save
    for (final day in daysToSave) {
      await db.upsertTimesheet(day.copyWith(
        weeklyTotalHours: Value(weeklyTotalHours),
        weeklyOt1Hours: Value(weeklyOtHours),
        estimatedPay: Value(estimatedPay),
      ));
    }
  }

  DailyStats _calculateDailyStats(List<PunchesLocalData> punches) {
    double totalMinutes = 0;
    PunchesLocalData? lastIn;

    for (final punch in punches) {
      if (punch.punchType == 'IN') {
        lastIn = punch;
      } else if (punch.punchType == 'OUT' && lastIn != null) {
        final duration = punch.timestampDevice.difference(lastIn.timestampDevice);
        totalMinutes += duration.inMinutes;
        lastIn = null;
      }
    }
    
    // TODO: Handle breaks (subtract break duration)
    
    double totalHours = totalMinutes / 60.0;
    
    // Basic NA1 Rule: > 8 hours is OT
    double regular = totalHours;
    double ot = 0;
    if (totalHours > 8) {
      regular = 8;
      ot = totalHours - 8;
    }
    
    return DailyStats(regularHours: regular, otHours: ot);
  }
}

class DailyStats {
  final double regularHours;
  final double otHours;
  DailyStats({required this.regularHours, required this.otHours});
}

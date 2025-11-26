import 'package:drift/drift.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:uuid/uuid.dart';

class TimesheetValidator {
  static const _uuid = Uuid();

  /// Validates a list of punches for a single day and returns any flags found.
  static List<TimesheetFlagsLocalCompanion> validateDay({
    required String employeeId,
    required DateTime date,
    required List<PunchesLocalData> punches,
  }) {
    final flags = <TimesheetFlagsLocalCompanion>[];

    // 1. Check for missing OUT punches
    // Sort punches by time
    final sortedPunches = List<PunchesLocalData>.from(punches)
      ..sort((a, b) => a.timestampDevice.compareTo(b.timestampDevice));

    PunchesLocalData? lastIn;
    for (final punch in sortedPunches) {
      if (punch.punchType == 'IN') {
        if (lastIn != null) {
          // Found IN followed by IN - missing OUT for the first one
          flags.add(_createFlag(
            employeeId: employeeId,
            date: date,
            punchId: lastIn.punchId,
            code: 'missing_out',
            message: 'Missing OUT punch before next IN',
            severity: 'error',
          ));
        }
        lastIn = punch;
      } else if (punch.punchType == 'OUT') {
        if (lastIn == null) {
          // Found OUT without IN - orphan OUT
          flags.add(_createFlag(
            employeeId: employeeId,
            date: date,
            punchId: punch.punchId,
            code: 'missing_in',
            message: 'OUT punch without matching IN',
            severity: 'error',
          ));
        } else {
          // Valid pair - check duration
          final duration = punch.timestampDevice.difference(lastIn.timestampDevice);
          if (duration.inHours > 16) {
             flags.add(_createFlag(
              employeeId: employeeId,
              date: date,
              punchId: lastIn.punchId,
              code: 'excessive_duration',
              message: 'Shift duration > 16 hours',
              severity: 'warning',
            ));
          }
          lastIn = null; // Reset
        }
      }
    }

    if (lastIn != null) {
      // Day ended with an IN punch
      // Only flag if it's been more than 16 hours or it's a past day
      final now = DateTime.now();
      final duration = now.difference(lastIn.timestampDevice);
      final isToday = now.year == date.year && now.month == date.month && now.day == date.day;
      
      if (!isToday || duration.inHours > 16) {
        flags.add(_createFlag(
          employeeId: employeeId,
          date: date,
          punchId: lastIn.punchId,
          code: 'missing_out',
          message: 'Shift still open',
          severity: 'error',
        ));
      }
    }

    // 2. Check GPS Accuracy
    for (final punch in punches) {
      if (punch.gpsAccuracy != null && punch.gpsAccuracy! > 80.0) {
        flags.add(_createFlag(
          employeeId: employeeId,
          date: date,
          punchId: punch.punchId,
          code: 'gps_accuracy',
          message: 'GPS accuracy > 80m (${punch.gpsAccuracy!.toStringAsFixed(1)}m)',
          severity: 'warning',
        ));
      }
    }

    // 3. Check for overlapping jobs (simplified)
    // This would require more complex logic checking time ranges across different job IDs
    
    return flags;
  }

  static TimesheetFlagsLocalCompanion _createFlag({
    required String employeeId,
    required DateTime date,
    String? punchId,
    required String code,
    required String message,
    required String severity,
  }) {
    return TimesheetFlagsLocalCompanion(
      flagId: Value(_uuid.v4()),
      employeeId: Value(employeeId),
      date: Value(date),
      punchId: punchId != null ? Value(punchId) : const Value.absent(),
      code: Value(code),
      message: Value(message),
      severity: Value(severity),
      resolved: const Value(false),
      createdAt: Value(DateTime.now()),
    );
  }
}

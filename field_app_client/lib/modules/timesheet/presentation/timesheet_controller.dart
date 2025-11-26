import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../offline/database/app_database.dart';
import '../../auth/application/auth_controller.dart';
import '../data/timesheet_repository.dart';

final timesheetControllerProvider = StreamProvider.family<List<TimesheetLocalData>, DateTime>((ref, weekStart) {
  final session = ref.watch(authSessionProvider);
  if (session == null) {
    return Stream.value([]);
  }
  
  final repository = ref.watch(timesheetRepositoryProvider);
  return repository.watchTimesheetsForWeek(session.employeeId, weekStart);
});

class TimesheetFlagsRequest {
  final String employeeId;
  final DateTime weekStart;
  
  TimesheetFlagsRequest(this.employeeId, this.weekStart);
  
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TimesheetFlagsRequest &&
          runtimeType == other.runtimeType &&
          employeeId == other.employeeId &&
          weekStart == other.weekStart;

  @override
  int get hashCode => employeeId.hashCode ^ weekStart.hashCode;
}

final timesheetFlagsProvider = StreamProvider.family<List<TimesheetFlagsLocalData>, TimesheetFlagsRequest>((ref, req) {
  final repository = ref.watch(timesheetRepositoryProvider);
  return repository.watchTimesheetFlags(req.employeeId, req.weekStart);
});

import 'package:drift/drift.dart';
import 'package:field_app_client/modules/timesheet/domain/timesheet_validator.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:test/test.dart';

void main() {
  group('TimesheetValidator', () {
    final date = DateTime(2025, 11, 26);
    const employeeId = '12';

    PunchesLocalData createPunch({
      required String type,
      required DateTime time,
      double? accuracy,
    }) {
      return PunchesLocalData(
        punchId: 'p-${time.millisecondsSinceEpoch}',
        employeeId: employeeId,
        jobId: 'job-1',
        serviceId: null,
        punchType: type,
        timestampDevice: time,
        gpsLat: 0,
        gpsLng: 0,
        gpsAccuracy: accuracy,
        gpsUnavailable: false,
        synced: false,
        syncAttempts: 0,
        source: 'mobile',
        deviceId: 'd1',
        lastError: null,
        requiresDispute: false,
        createdAt: time,
        updatedAt: time,
      );
    }

    test('detects missing OUT punch', () {
      final punches = [
        createPunch(type: 'IN', time: date.add(const Duration(hours: 8))),
        createPunch(type: 'IN', time: date.add(const Duration(hours: 12))),
      ];

      final flags = TimesheetValidator.validateDay(
        employeeId: employeeId,
        date: date,
        punches: punches,
      );

      expect(flags, hasLength(1));
      expect(flags.first.code.value, 'missing_out');
      expect(flags.first.punchId.value, punches.first.punchId);
    });

    test('detects missing IN punch', () {
      final punches = [
        createPunch(type: 'OUT', time: date.add(const Duration(hours: 17))),
      ];

      final flags = TimesheetValidator.validateDay(
        employeeId: employeeId,
        date: date,
        punches: punches,
      );

      expect(flags, hasLength(1));
      expect(flags.first.code.value, 'missing_in');
    });

    test('detects excessive duration (>16h)', () {
      final punches = [
        createPunch(type: 'IN', time: date.add(const Duration(hours: 6))),
        createPunch(type: 'OUT', time: date.add(const Duration(hours: 23))),
      ];

      final flags = TimesheetValidator.validateDay(
        employeeId: employeeId,
        date: date,
        punches: punches,
      );

      expect(flags, hasLength(1));
      expect(flags.first.code.value, 'excessive_duration');
    });

    test('detects GPS accuracy issues', () {
      final punches = [
        createPunch(type: 'IN', time: date.add(const Duration(hours: 8)), accuracy: 100.0),
        createPunch(type: 'OUT', time: date.add(const Duration(hours: 17)), accuracy: 10.0),
      ];

      final flags = TimesheetValidator.validateDay(
        employeeId: employeeId,
        date: date,
        punches: punches,
      );

      expect(flags, hasLength(1));
      expect(flags.first.code.value, 'gps_accuracy');
    });

    test('validates clean day correctly', () {
      final punches = [
        createPunch(type: 'IN', time: date.add(const Duration(hours: 8))),
        createPunch(type: 'OUT', time: date.add(const Duration(hours: 12))),
        createPunch(type: 'IN', time: date.add(const Duration(hours: 13))),
        createPunch(type: 'OUT', time: date.add(const Duration(hours: 17))),
      ];

      final flags = TimesheetValidator.validateDay(
        employeeId: employeeId,
        date: date,
        punches: punches,
      );

      expect(flags, isEmpty);
    });
  });
}

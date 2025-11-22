import 'package:field_app_client/modules/jobs/application/foreman_job_controller.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('buildForemanEntries merges crew + punch state', () {
    final now = DateTime(2025, 11, 21, 9, 0);
    const crewJson =
        '[{"employee_id":"EMP-1","name":"Alex","role":"Lead","status":"IN"},'
        '{"employee_id":"EMP-2","name":"Brooke","role":"Tech","status":"OUT"}]';
    final job = JobsLocalData(
      jobId: 'JOB-100',
      serviceId: 'SRV-1',
      customerName: 'Warehouse Tear-off',
      address: '123 Main St',
      scheduledDate: now.add(const Duration(hours: 3)),
      foremanId: 'EMP-204',
      crewListJson: crewJson,
      crewHash: null,
      lastUpdated: now,
      synced: true,
    );

    final crewInPunch = PunchesLocalData(
      punchId: 'p-1',
      employeeId: 'EMP-1',
      jobId: 'JOB-100',
      serviceId: null,
      punchType: 'IN',
      timestampDevice: now.subtract(const Duration(minutes: 5)),
      gpsLat: null,
      gpsLng: null,
      gpsAccuracy: null,
      gpsUnavailable: false,
      synced: false,
      syncAttempts: 0,
      source: 'mobile_app',
      deviceId: 'dev-1',
      lastError: null,
      requiresDispute: false,
      createdAt: now.subtract(const Duration(minutes: 5)),
      updatedAt: now.subtract(const Duration(minutes: 5)),
    );

    final otherJobPunch = PunchesLocalData(
      punchId: 'p-2',
      employeeId: 'EMP-2',
      jobId: 'JOB-999',
      serviceId: null,
      punchType: 'IN',
      timestampDevice: now.subtract(const Duration(minutes: 3)),
      gpsLat: null,
      gpsLng: null,
      gpsAccuracy: null,
      gpsUnavailable: false,
      synced: true,
      syncAttempts: 0,
      source: 'job_clock',
      deviceId: 'dev-2',
      lastError: null,
      requiresDispute: false,
      createdAt: now.subtract(const Duration(minutes: 3)),
      updatedAt: now.subtract(const Duration(minutes: 3)),
    );

    final entries = buildForemanEntries(
      [job],
      [crewInPunch, otherJobPunch],
      'EMP-204',
    );

    expect(entries, hasLength(1));
    final entry = entries.first;
    expect(entry.unsyncedPunchCount, 1);
    expect(entry.crew, hasLength(2));

    final alex = entry.crew.firstWhere(
      (member) => member.employeeId == 'EMP-1',
    );
    expect(alex.presence, CrewPresenceState.clockedIn);
    expect(alex.hasUnsyncedPunches, isTrue);
    expect(alex.isOffAssignment, isFalse);

    final brooke = entry.crew.firstWhere(
      (member) => member.employeeId == 'EMP-2',
    );
    expect(brooke.presence, CrewPresenceState.clockedIn);
    expect(brooke.source, 'job_clock');
    expect(brooke.isOffAssignment, isTrue);
  });

  test('filters jobs by foremanId when present', () {
    final now = DateTime(2025, 11, 21);
    const crewJson =
        '[{"employee_id":"EMP-1","name":"Alex","role":null,"status":"IN"}]';
    final ownedJob = JobsLocalData(
      jobId: 'JOB-1',
      serviceId: 'SRV',
      customerName: 'My Crew',
      address: null,
      scheduledDate: now,
      foremanId: 'EMP-204',
      crewListJson: crewJson,
      crewHash: null,
      lastUpdated: now,
      synced: true,
    );
    final otherJob = JobsLocalData(
      jobId: 'JOB-2',
      serviceId: 'SRV',
      customerName: 'Other Foreman',
      address: null,
      scheduledDate: now,
      foremanId: 'EMP-999',
      crewListJson: crewJson,
      crewHash: null,
      lastUpdated: now,
      synced: true,
    );

    final entries = buildForemanEntries(
      [ownedJob, otherJob],
      const [],
      'EMP-204',
    );

    expect(entries, hasLength(1));
    expect(entries.first.jobId, 'JOB-1');
  });
}

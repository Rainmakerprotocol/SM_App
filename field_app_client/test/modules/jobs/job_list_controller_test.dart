import 'package:flutter_test/flutter_test.dart';

import 'package:field_app_client/offline/database/app_database.dart';
import 'package:field_app_client/modules/jobs/application/job_list_controller.dart';

void main() {
  group('JobListBuckets', () {
    test('categorizes rows into the correct buckets', () {
      final now = DateTime.utc(2025, 11, 21, 9);
      final rows = [
        _jobRow('today', now),
        _jobRow('this-week', now.add(const Duration(days: 2))),
        _jobRow('last-week', now.subtract(const Duration(days: 8))),
      ];

      final buckets = JobListBuckets.fromRows(rows, now);

      expect(buckets.today.map((job) => job.jobId).toList(), ['today']);
      expect(buckets.thisWeek.map((job) => job.jobId).toList(), ['this-week']);
      expect(buckets.lastWeek.map((job) => job.jobId).toList(), ['last-week']);
    });

    test('parses crew names safely', () {
      final now = DateTime.utc(2025, 11, 21, 9);
      final row = JobsLocalData(
        jobId: 'job-crew',
        serviceId: 'svc-2',
        customerName: 'Crew Test',
        address: null,
        scheduledDate: now,
        foremanId: null,
        crewListJson: r'[{"name":"Ana"},{"name":"Ben"}]',
        crewHash: 'hash',
        lastUpdated: now,
        synced: true,
      );

      final entry = JobListEntry.fromLocal(row);

      expect(entry.hasCrew, isTrue);
      expect(entry.crewNames, ['Ana', 'Ben']);
    });
  });
}

JobsLocalData _jobRow(String id, DateTime scheduled) => JobsLocalData(
  jobId: id,
  serviceId: 'svc-1',
  customerName: 'Job $id',
  address: '123 Main',
  scheduledDate: scheduled,
  foremanId: null,
  crewListJson: '[]',
  crewHash: null,
  lastUpdated: scheduled,
  synced: true,
);

import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../api/job_service.dart';
import '../../../modules/auth/domain/auth_models.dart';
import '../../../offline/database/app_database.dart';
import '../../../offline/offline_providers.dart';

typedef Clock = DateTime Function();

final jobsRepositoryProvider = Provider<JobsRepository>((ref) {
  return JobsRepository(
    jobService: ref.watch(jobServiceProvider),
    jobsDao: ref.watch(jobsDaoProvider),
    clock: () => DateTime.now(),
  );
});

class JobsRepository {
  JobsRepository({
    required this.jobService,
    required this.jobsDao,
    required Clock clock,
  }) : _clock = clock;

  final JobService jobService;
  final JobsDao jobsDao;
  final Clock _clock;

  Future<JobFeed> refreshJobs({
    required AuthSession session,
    required String employeeId,
    DateTime? start,
    DateTime? end,
  }) async {
    final feed = await jobService.fetchJobs(
      session: session,
      employeeId: employeeId,
      start: start,
      end: end,
    );

    final fetchedAt = _clock();

    final entries = feed.jobs
        .map((job) => _toCompanion(job, fetchedAt))
        .toList();
    if (entries.isNotEmpty) {
      await jobsDao.upsertMany(entries);
    }

    await jobsDao.upsertFeedState(
      JobFeedStateLocalCompanion(
        employeeId: Value(feed.employeeId),
        rangeStart: Value(feed.range.start),
        rangeEnd: Value(feed.range.end),
        lastRefreshed: Value(fetchedAt),
        apiVersion: Value(feed.apiVersion),
        nextCursor: Value(feed.nextCursor),
      ),
    );

    return feed;
  }

  JobsLocalCompanion _toCompanion(JobSummary job, DateTime fetchedAt) {
    final scheduled = _resolveScheduledDate(job) ?? fetchedAt;
    final crewJson = _encodeCrew(job.crew);
    final crewHash = crewJson == '[]'
        ? null
        : sha1.convert(utf8.encode(crewJson)).toString();
    final primaryServiceId = job.services.isNotEmpty
        ? job.services.first.serviceId
        : 'unassigned';

    return JobsLocalCompanion(
      jobId: Value(
        job.jobId.isEmpty
            ? 'job-${sha1.convert(utf8.encode(job.title))}'
            : job.jobId,
      ),
      serviceId: Value(
        primaryServiceId.isEmpty ? 'unassigned' : primaryServiceId,
      ),
      customerName: Value(job.title),
      address: Value(job.address),
      scheduledDate: Value(scheduled),
      foremanId: const Value(null),
      crewListJson: Value(crewJson),
      crewHash: Value(crewHash),
      lastUpdated: Value(fetchedAt),
      synced: const Value(true),
    );
  }

  String _encodeCrew(List<JobCrewMember> crew) {
    if (crew.isEmpty) {
      return '[]';
    }
    final payload = crew
        .map(
          (member) => {
            'employee_id': member.employeeId,
            'name': member.name,
            'role': member.role,
            'status': member.status,
          },
        )
        .toList();
    return jsonEncode(payload);
  }

  DateTime? _resolveScheduledDate(JobSummary job) {
    final rawDate = job.scheduledDate;
    if (rawDate == null) {
      return null;
    }
    final parsed = DateTime.tryParse(rawDate);
    if (parsed == null) {
      return null;
    }
    final rawTime = job.scheduledTime;
    if (rawTime == null) {
      return parsed;
    }
    final parts = rawTime.split(':');
    final hour = int.tryParse(parts.isNotEmpty ? parts[0] : '') ?? 0;
    final minute = int.tryParse(parts.length > 1 ? parts[1] : '') ?? 0;
    return DateTime(parsed.year, parsed.month, parsed.day, hour, minute);
  }
}

import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../offline/database/app_database.dart';
import '../../../offline/offline_providers.dart';
import '../../auth/application/auth_controller.dart';
import '../../auth/domain/auth_models.dart';
import '../../profile/application/profile_summary_provider.dart';
import '../data/jobs_repository.dart';

typedef JobsClock = DateTime Function();

final jobListClockProvider = Provider<JobsClock>((ref) {
  return () => DateTime.now();
});

final jobBucketsProvider = StreamProvider.autoDispose<JobListBuckets>((ref) {
  final jobsDao = ref.watch(jobsDaoProvider);
  final now = ref.watch(jobListClockProvider)();
  final startOfWeek = _startOfWeek(now);
  final rangeStart = startOfWeek.subtract(const Duration(days: 7));
  final rangeEnd = startOfWeek.add(const Duration(days: 7));
  return jobsDao
      .watchWindow(start: rangeStart, end: rangeEnd)
      .map((rows) => JobListBuckets.fromRows(rows, now));
});

final jobFeedStatusProvider = StreamProvider.autoDispose<JobFeedStatus>((ref) {
  final jobsDao = ref.watch(jobsDaoProvider);
  final employeeId = ref.watch(profileSummaryProvider).employeeId;
  return jobsDao
      .watchFeedState(employeeId)
      .map(
        (state) => JobFeedStatus(
          employeeId: employeeId,
          lastRefreshed: state?.lastRefreshed,
          rangeStart: state?.rangeStart,
          rangeEnd: state?.rangeEnd,
          apiVersion: state?.apiVersion,
        ),
      );
});

final jobListRefresherProvider = Provider<JobListRefresher>((ref) {
  return JobListRefresher(ref);
});

class JobListRefresher {
  const JobListRefresher(this._ref);

  final Ref _ref;

  Future<void> refresh() async {
    final session = _ref.read(authSessionProvider);
    if (session == null) {
      throw const JobRefreshException('Sign in to refresh the job feed.');
    }
    final employeeId = _ref.read(profileSummaryProvider).employeeId;
    final now = _ref.read(jobListClockProvider)();
    final startOfWeek = _startOfWeek(now);
    final endOfWeek = startOfWeek.add(const Duration(days: 7));

    try {
      await _ref
          .read(jobsRepositoryProvider)
          .refreshJobs(
            session: session,
            employeeId: employeeId,
            start: startOfWeek,
            end: endOfWeek,
          );
    } on AuthException catch (error) {
      throw JobRefreshException(error.message);
    } catch (_) {
      throw const JobRefreshException('Unable to refresh jobs right now.');
    }
  }
}

class JobRefreshException implements Exception {
  const JobRefreshException(this.message);
  final String message;
}

class JobFeedStatus {
  const JobFeedStatus({
    required this.employeeId,
    this.lastRefreshed,
    this.rangeStart,
    this.rangeEnd,
    this.apiVersion,
  });

  final String employeeId;
  final DateTime? lastRefreshed;
  final DateTime? rangeStart;
  final DateTime? rangeEnd;
  final String? apiVersion;
}

class JobListBuckets {
  const JobListBuckets({
    required this.today,
    required this.thisWeek,
    required this.lastWeek,
  });

  final List<JobListEntry> today;
  final List<JobListEntry> thisWeek;
  final List<JobListEntry> lastWeek;

  bool get isEmpty => today.isEmpty && thisWeek.isEmpty && lastWeek.isEmpty;

  static JobListBuckets fromRows(List<JobsLocalData> rows, DateTime now) {
    final startOfToday = DateTime(now.year, now.month, now.day);
    final startOfTomorrow = startOfToday.add(const Duration(days: 1));
    final startOfWeek = _startOfWeek(startOfToday);
    final startOfNextWeek = startOfWeek.add(const Duration(days: 7));
    final startOfLastWeek = startOfWeek.subtract(const Duration(days: 7));

    final today = <JobListEntry>[];
    final thisWeek = <JobListEntry>[];
    final lastWeek = <JobListEntry>[];

    for (final row in rows) {
      final entry = JobListEntry.fromLocal(row);
      final scheduled = entry.scheduledDate;
      if (!_isOnOrAfter(scheduled, startOfLastWeek) ||
          scheduled.isAfter(startOfNextWeek)) {
        continue;
      }

      if (_isOnOrAfter(scheduled, startOfToday) &&
          scheduled.isBefore(startOfTomorrow)) {
        today.add(entry);
      } else if (_isOnOrAfter(scheduled, startOfWeek) &&
          scheduled.isBefore(startOfNextWeek)) {
        thisWeek.add(entry);
      } else if (_isOnOrAfter(scheduled, startOfLastWeek) &&
          scheduled.isBefore(startOfWeek)) {
        lastWeek.add(entry);
      }
    }

    int compare(JobListEntry a, JobListEntry b) =>
        a.scheduledDate.compareTo(b.scheduledDate);

    today.sort(compare);
    thisWeek.sort(compare);
    lastWeek.sort(compare);

    return JobListBuckets(today: today, thisWeek: thisWeek, lastWeek: lastWeek);
  }
}

class JobListEntry {
  const JobListEntry({
    required this.jobId,
    required this.serviceId,
    required this.title,
    this.address,
    required this.scheduledDate,
    required this.crewNames,
    required this.lastUpdated,
  });

  final String jobId;
  final String serviceId;
  final String title;
  final String? address;
  final DateTime scheduledDate;
  final List<String> crewNames;
  final DateTime lastUpdated;

  bool get hasCrew => crewNames.isNotEmpty;

  factory JobListEntry.fromLocal(JobsLocalData data) {
    return JobListEntry(
      jobId: data.jobId,
      serviceId: data.serviceId,
      title: data.customerName,
      address: data.address,
      scheduledDate: data.scheduledDate,
      crewNames: _parseCrewNames(data.crewListJson),
      lastUpdated: data.lastUpdated,
    );
  }
}

List<String> _parseCrewNames(String raw) {
  try {
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map((item) => (item as Map<String, dynamic>)['name']?.toString())
        .whereType<String>()
        .where((name) => name.isNotEmpty)
        .toList();
  } catch (_) {
    return const [];
  }
}

DateTime _startOfWeek(DateTime anchor) {
  final weekday = anchor.weekday; // Monday = 1
  final delta = weekday - DateTime.monday;
  return DateTime(
    anchor.year,
    anchor.month,
    anchor.day,
  ).subtract(Duration(days: delta));
}

bool _isOnOrAfter(DateTime value, DateTime reference) =>
    !value.isBefore(reference);

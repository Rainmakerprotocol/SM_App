import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meta/meta.dart';

import '../../../offline/database/app_database.dart';
import '../../../offline/offline_providers.dart';
import '../../profile/application/profile_summary_provider.dart';
import 'job_list_controller.dart';

final _foremanJobWindowStreamProvider =
    StreamProvider.autoDispose<List<JobsLocalData>>((ref) {
      final jobsDao = ref.watch(jobsDaoProvider);
      final now = ref.watch(jobListClockProvider)();
      final start = now.subtract(const Duration(days: 14));
      final end = now.add(const Duration(days: 14));
      return jobsDao.watchWindow(start: start, end: end);
    });

final _punchesStreamProvider =
    StreamProvider.autoDispose<List<PunchesLocalData>>((ref) {
      final punchesDao = ref.watch(punchesDaoProvider);
      return punchesDao.watchAll();
    });

final foremanJobsProvider =
    Provider.autoDispose<AsyncValue<List<ForemanJobEntry>>>((ref) {
      final jobsAsync = ref.watch(_foremanJobWindowStreamProvider);
      final punchesAsync = ref.watch(_punchesStreamProvider);

      return switch ((jobsAsync, punchesAsync)) {
        (AsyncData(value: final jobRows), AsyncData(value: final punchRows)) =>
          AsyncValue.data(
            buildForemanEntries(
              jobRows,
              punchRows,
              ref.watch(profileSummaryProvider).employeeId,
            ),
          ),
        (AsyncError(:final error, :final stackTrace), _) => AsyncValue.error(
          error,
          stackTrace,
        ),
        (_, AsyncError(:final error, :final stackTrace)) => AsyncValue.error(
          error,
          stackTrace,
        ),
        (AsyncLoading(), _) => const AsyncValue.loading(),
        (_, AsyncLoading()) => const AsyncValue.loading(),
        _ => const AsyncValue.loading(),
      };
    });

class ForemanJobEntry {
  const ForemanJobEntry({
    required this.jobId,
    required this.serviceId,
    required this.customerName,
    required this.address,
    required this.scheduledDate,
    required this.lastUpdated,
    required this.crew,
    required this.unsyncedPunchCount,
    required this.isPastDue,
  });

  final String jobId;
  final String serviceId;
  final String customerName;
  final String? address;
  final DateTime scheduledDate;
  final DateTime lastUpdated;
  final List<CrewAssignmentStatus> crew;
  final int unsyncedPunchCount;
  final bool isPastDue;

  bool get hasCrew => crew.isNotEmpty;
  bool get hasUnsyncedPunches => unsyncedPunchCount > 0;
}

class CrewAssignmentStatus {
  const CrewAssignmentStatus({
    required this.employeeId,
    required this.name,
    required this.role,
    required this.backendStatus,
    required this.presence,
    required this.currentJobId,
    required this.source,
    required this.lastPunchAt,
    required this.hasUnsyncedPunches,
    required this.isOffAssignment,
  });

  final String employeeId;
  final String name;
  final String? role;
  final String backendStatus;
  final CrewPresenceState presence;
  final String? currentJobId;
  final String source;
  final DateTime? lastPunchAt;
  final bool hasUnsyncedPunches;
  final bool isOffAssignment;

  bool get hasRecentPunch => lastPunchAt != null;
}

enum CrewPresenceState { clockedIn, clockedOut, breakActive, unknown }

@visibleForTesting
List<ForemanJobEntry> buildForemanEntries(
  List<JobsLocalData> jobRows,
  List<PunchesLocalData> punches,
  String foremanEmployeeId,
) {
  final sortedJobs = [...jobRows]
    ..sort((a, b) => a.scheduledDate.compareTo(b.scheduledDate));
  final scopedJobs = sortedJobs.where((job) {
    final foremanId = job.foremanId;
    if (foremanId == null || foremanId.isEmpty) {
      return true;
    }
    return foremanId == foremanEmployeeId;
  });
  final punchesByEmployee = <String, List<PunchesLocalData>>{};
  for (final punch in punches) {
    (punchesByEmployee[punch.employeeId] ??= []).add(punch);
  }
  for (final entries in punchesByEmployee.values) {
    entries.sort((a, b) => a.timestampDevice.compareTo(b.timestampDevice));
  }

  final now = DateTime.now();
  return scopedJobs.map((job) {
    final crewRecords = _decodeCrew(job.crewListJson);
    final crew = crewRecords.map((crewMember) {
      final punchHistory =
          punchesByEmployee[crewMember.employeeId] ??
          const <PunchesLocalData>[];
      final latestPunch = punchHistory.isEmpty ? null : punchHistory.last;
      final presence = _presenceFromPunch(latestPunch?.punchType);
      final hasUnsynced = punchHistory.any((punch) => punch.synced == false);
      final currentJobId = latestPunch?.jobId;
      final source = latestPunch?.source ?? 'job_clock';
      final isOffAssignment =
          currentJobId != null &&
          currentJobId.isNotEmpty &&
          currentJobId != job.jobId &&
          presence == CrewPresenceState.clockedIn;
      return CrewAssignmentStatus(
        employeeId: crewMember.employeeId,
        name: crewMember.name,
        role: crewMember.role,
        backendStatus: crewMember.status,
        presence: presence,
        currentJobId: currentJobId,
        source: source,
        lastPunchAt: latestPunch?.timestampDevice,
        hasUnsyncedPunches: hasUnsynced,
        isOffAssignment: isOffAssignment,
      );
    }).toList();

    final unsyncedPunchCount = punches
        .where((punch) => punch.synced == false && punch.jobId == job.jobId)
        .length;

    return ForemanJobEntry(
      jobId: job.jobId,
      serviceId: job.serviceId,
      customerName: job.customerName,
      address: job.address,
      scheduledDate: job.scheduledDate,
      lastUpdated: job.lastUpdated,
      crew: crew,
      unsyncedPunchCount: unsyncedPunchCount,
      isPastDue: job.scheduledDate.isBefore(now),
    );
  }).toList();
}

CrewPresenceState _presenceFromPunch(String? punchType) {
  switch (punchType) {
    case 'IN':
      return CrewPresenceState.clockedIn;
    case 'OUT':
      return CrewPresenceState.clockedOut;
    case 'BREAK_START':
      return CrewPresenceState.breakActive;
    case 'BREAK_END':
      return CrewPresenceState.clockedIn;
    default:
      return CrewPresenceState.unknown;
  }
}

List<_CrewRecord> _decodeCrew(String raw) {
  if (raw.isEmpty || raw == '[]') {
    return const [];
  }
  try {
    final decoded = jsonDecode(raw) as List<dynamic>;
    return decoded
        .map(
          (item) => _CrewRecord(
            employeeId: item['employee_id']?.toString() ?? '',
            name: item['name']?.toString() ?? 'Crew Member',
            role: item['role']?.toString(),
            status: item['status']?.toString() ?? 'UNKNOWN',
          ),
        )
        .toList();
  } catch (_) {
    return const [];
  }
}

class _CrewRecord {
  const _CrewRecord({
    required this.employeeId,
    required this.name,
    required this.role,
    required this.status,
  });

  final String employeeId;
  final String name;
  final String? role;
  final String status;
}

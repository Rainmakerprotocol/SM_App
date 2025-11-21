import 'dart:convert' as convert;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../core/network/http_client_provider.dart';
import '../modules/auth/domain/auth_models.dart';

class JobFeed {
  JobFeed({required this.employeeId, required this.range, required this.jobs});

  final String employeeId;
  final JobFeedRange range;
  final List<JobSummary> jobs;

  factory JobFeed.fromJson(Map<String, dynamic> json) {
    return JobFeed(
      employeeId: json['employee_id']?.toString() ?? '',
      range: JobFeedRange.fromJson(
        json['range'] as Map<String, dynamic>? ?? const <String, dynamic>{},
      ),
      jobs: ((json['jobs'] as List?) ?? const [])
          .map((item) => JobSummary.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class JobFeedRange {
  const JobFeedRange({required this.start, required this.end});
  final DateTime? start;
  final DateTime? end;

  factory JobFeedRange.fromJson(Map<String, dynamic> json) {
    DateTime? parse(String? raw) => raw == null ? null : DateTime.tryParse(raw);
    return JobFeedRange(
      start: parse(json['start'] as String?),
      end: parse(json['end'] as String?),
    );
  }
}

class JobSummary {
  JobSummary({
    required this.jobId,
    required this.title,
    required this.address,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.services,
    required this.crew,
  });

  final String jobId;
  final String title;
  final String? address;
  final String? scheduledDate;
  final String? scheduledTime;
  final List<JobServiceItem> services;
  final List<JobCrewMember> crew;

  factory JobSummary.fromJson(Map<String, dynamic> json) {
    return JobSummary(
      jobId: json['job_id']?.toString() ?? '',
      title: json['title']?.toString() ?? 'Job',
      address: json['address']?.toString(),
      scheduledDate: json['scheduled_date']?.toString(),
      scheduledTime: json['scheduled_time']?.toString(),
      services: ((json['services'] as List?) ?? const [])
          .map((item) => JobServiceItem.fromJson(item as Map<String, dynamic>))
          .toList(),
      crew: ((json['crew'] as List?) ?? const [])
          .map((item) => JobCrewMember.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class JobServiceItem {
  const JobServiceItem({
    required this.jobItemId,
    required this.serviceId,
    required this.serviceName,
    required this.status,
  });

  final String jobItemId;
  final String serviceId;
  final String serviceName;
  final int status;

  factory JobServiceItem.fromJson(Map<String, dynamic> json) {
    return JobServiceItem(
      jobItemId: json['job_item_id']?.toString() ?? '',
      serviceId: json['service_id']?.toString() ?? '',
      serviceName: json['service_name']?.toString() ?? 'Service',
      status: int.tryParse(json['status']?.toString() ?? '') ?? 0,
    );
  }
}

class JobCrewMember {
  const JobCrewMember({
    required this.employeeId,
    required this.name,
    required this.role,
    required this.status,
  });

  final String employeeId;
  final String name;
  final String? role;
  final String status;

  factory JobCrewMember.fromJson(Map<String, dynamic> json) {
    return JobCrewMember(
      employeeId: json['employee_id']?.toString() ?? '',
      name: json['name']?.toString() ?? 'Crew Member',
      role: json['role']?.toString(),
      status: json['status']?.toString() ?? 'UNKNOWN',
    );
  }
}

abstract class JobService {
  Future<JobFeed> fetchJobs({
    required AuthSession session,
    required String employeeId,
    DateTime? start,
    DateTime? end,
  });
}

class RestJobService implements JobService {
  RestJobService({required this.httpClient, required this.baseUrl});

  final http.Client httpClient;
  final String baseUrl;

  @override
  Future<JobFeed> fetchJobs({
    required AuthSession session,
    required String employeeId,
    DateTime? start,
    DateTime? end,
  }) async {
    final query = <String, String>{};
    if (start != null) {
      query['start'] = start.toIso8601String();
    }
    if (end != null) {
      query['end'] = end.toIso8601String();
    }

    final uri = Uri.parse(
      '$baseUrl/api/mobile/jobs/$employeeId',
    ).replace(queryParameters: query.isEmpty ? null : query);
    final response = await httpClient.get(
      uri,
      headers: {'Authorization': 'Bearer ${session.token}'},
    );

    if (response.statusCode == 401) {
      throw AuthException('Session expired', code: 'unauthorized');
    }

    if (response.statusCode >= 500) {
      throw AuthException('Jobs unavailable (server error)', code: 'server');
    }

    if (response.statusCode >= 400) {
      throw AuthException('Invalid job request', code: 'invalid_request');
    }

    final decoded = convert.jsonDecode(response.body) as Map<String, dynamic>;
    return JobFeed.fromJson(decoded);
  }
}

class MockJobService implements JobService {
  @override
  Future<JobFeed> fetchJobs({
    required AuthSession session,
    required String employeeId,
    DateTime? start,
    DateTime? end,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return JobFeed(
      employeeId: employeeId,
      range: JobFeedRange(start: start, end: end),
      jobs: [
        JobSummary(
          jobId: '245',
          title: '123 Main - Tear-off',
          address: '123 Main St, Flint, MI',
          scheduledDate: DateTime.now().toIso8601String(),
          scheduledTime: '08:00',
          services: const [
            JobServiceItem(
              jobItemId: '611',
              serviceId: '4',
              serviceName: 'Roofing',
              status: 3,
            ),
          ],
          crew: const [
            JobCrewMember(
              employeeId: '12',
              name: 'John Doe',
              role: 'Installer',
              status: 'IN',
            ),
          ],
        ),
      ],
    );
  }
}

final jobServiceProvider = Provider<JobService>((ref) {
  if (AppConfig.useMockJobsApi) {
    return MockJobService();
  }
  return RestJobService(
    httpClient: ref.watch(httpClientProvider),
    baseUrl: AppConfig.apiBaseUrl,
  );
});

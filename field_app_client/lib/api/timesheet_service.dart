import 'dart:convert' as convert;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../core/network/http_client_provider.dart';
import '../modules/auth/domain/auth_models.dart';

class TimesheetWeek {
  TimesheetWeek({
    required this.employeeId,
    required this.start,
    required this.end,
    required this.days,
    required this.weeklyTotalHours,
    required this.weeklyOvertimeHours,
    required this.estimatedPay,
  });

  final String employeeId;
  final DateTime? start;
  final DateTime? end;
  final List<TimesheetDay> days;
  final double weeklyTotalHours;
  final double weeklyOvertimeHours;
  final double? estimatedPay;

  factory TimesheetWeek.fromJson(Map<String, dynamic> json) {
    DateTime? parseDate(String? raw) =>
        raw == null ? null : DateTime.tryParse(raw);
    final range =
        json['week'] as Map<String, dynamic>? ?? const <String, dynamic>{};
    return TimesheetWeek(
      employeeId: json['employee_id']?.toString() ?? '',
      start: parseDate(range['start'] as String?),
      end: parseDate(range['end'] as String?),
      days: ((json['days'] as List?) ?? const [])
          .map((item) => TimesheetDay.fromJson(item as Map<String, dynamic>))
          .toList(),
      weeklyTotalHours:
          double.tryParse(json['weekly_total_hours']?.toString() ?? '') ?? 0,
      weeklyOvertimeHours:
          double.tryParse(json['weekly_ot1_hours']?.toString() ?? '') ?? 0,
      estimatedPay: json['estimated_pay'] == null
          ? null
          : double.tryParse(json['estimated_pay'].toString()),
    );
  }
}

class TimesheetDay {
  TimesheetDay({
    required this.date,
    required this.punches,
    required this.regularHours,
    required this.otHours,
    this.notes,
  });

  final DateTime? date;
  final List<TimesheetPunch> punches;
  final double regularHours;
  final double otHours;
  final String? notes;

  factory TimesheetDay.fromJson(Map<String, dynamic> json) {
    return TimesheetDay(
      date: json['date'] == null
          ? null
          : DateTime.tryParse(json['date'].toString()),
      punches: ((json['punches'] as List?) ?? const [])
          .map((item) => TimesheetPunch.fromJson(item as Map<String, dynamic>))
          .toList(),
      regularHours:
          double.tryParse(json['regular_hours']?.toString() ?? '') ?? 0,
      otHours: double.tryParse(json['ot_hours']?.toString() ?? '') ?? 0,
      notes: json['notes']?.toString(),
    );
  }
}

class TimesheetPunch {
  TimesheetPunch({
    required this.uuid,
    required this.jobId,
    required this.startTime,
    required this.endTime,
    required this.costCode,
    required this.source,
  });

  final String uuid;
  final String? jobId;
  final String? startTime;
  final String? endTime;
  final String? costCode;
  final String source;

  factory TimesheetPunch.fromJson(Map<String, dynamic> json) {
    return TimesheetPunch(
      uuid: json['uuid']?.toString() ?? '',
      jobId: json['job_id']?.toString(),
      startTime: json['start_time']?.toString(),
      endTime: json['end_time']?.toString(),
      costCode: json['cost_code']?.toString(),
      source: json['source']?.toString() ?? 'unknown',
    );
  }
}

abstract class TimesheetService {
  Future<TimesheetWeek> fetchWeek({
    required AuthSession session,
    required String employeeId,
    required DateTime weekStart,
  });
}

class RestTimesheetService implements TimesheetService {
  RestTimesheetService({required this.httpClient, required this.baseUrl});

  final http.Client httpClient;
  final String baseUrl;

  @override
  Future<TimesheetWeek> fetchWeek({
    required AuthSession session,
    required String employeeId,
    required DateTime weekStart,
  }) async {
    final uri = Uri.parse(
      '$baseUrl/api/mobile/timesheet/week/$employeeId',
    ).replace(queryParameters: {'start': weekStart.toIso8601String()});

    final response = await httpClient.get(
      uri,
      headers: {'Authorization': 'Bearer ${session.token}'},
    );

    if (response.statusCode == 401) {
      throw AuthException('Session expired', code: 'unauthorized');
    }

    if (response.statusCode >= 500) {
      throw AuthException('Timesheet unavailable', code: 'server');
    }

    if (response.statusCode >= 400) {
      throw AuthException('Invalid timesheet request', code: 'invalid_request');
    }

    return TimesheetWeek.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

class MockTimesheetService implements TimesheetService {
  @override
  Future<TimesheetWeek> fetchWeek({
    required AuthSession session,
    required String employeeId,
    required DateTime weekStart,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return TimesheetWeek(
      employeeId: employeeId,
      start: weekStart,
      end: weekStart.add(const Duration(days: 6)),
      weeklyTotalHours: 38.5,
      weeklyOvertimeHours: 2.5,
      estimatedPay: 1025.5,
      days: [
        TimesheetDay(
          date: weekStart,
          regularHours: 7.0,
          otHours: 0.5,
          notes: 'Mock shift',
          punches: [
            TimesheetPunch(
              uuid: 'mock-uuid',
              jobId: '245',
              startTime: '08:00',
              endTime: '15:30',
              costCode: '3',
              source: 'mobile_app',
            ),
          ],
        ),
      ],
    );
  }
}

final timesheetServiceProvider = Provider<TimesheetService>((ref) {
  if (AppConfig.useMockTimesheetApi) {
    return MockTimesheetService();
  }
  return RestTimesheetService(
    httpClient: ref.watch(httpClientProvider),
    baseUrl: AppConfig.apiBaseUrl,
  );
});

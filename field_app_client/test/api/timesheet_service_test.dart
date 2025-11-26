import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:field_app_client/api/timesheet_service.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';

class _MockHttpClient extends Mock implements http.Client {}

void main() {
  final session = AuthSession(
    token: 'token',
    expiresAt: DateTime(2099, 1, 1),
    displayName: 'Tester',
    employeeId: '12',
  );

  group('RestTimesheetService', () {
    test('parses weekly payload', () async {
      final client = _MockHttpClient();
      final service = RestTimesheetService(
        httpClient: client,
        baseUrl: 'https://example.com',
      );

      final uri = Uri.parse('https://example.com/api/mobile/timesheet/week/12')
          .replace(
            queryParameters: {
              'start': DateTime(2025, 11, 17).toIso8601String(),
            },
          );

      when(() => client.get(uri, headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response(
          jsonEncode({
            'employee_id': 12,
            'week': {'start': '2025-11-17', 'end': '2025-11-23'},
            'days': [
              {
                'date': '2025-11-20',
                'regular_hours': 7.0,
                'ot_hours': 0.5,
                'notes': '',
                'punches': [
                  {
                    'uuid': 'ba9f6fd7',
                    'job_id': 245,
                    'start_time': '08:00',
                    'end_time': '15:30',
                    'cost_code': 3,
                    'source': 'mobile_app',
                  },
                ],
              },
            ],
            'weekly_total_hours': 38.5,
            'weekly_ot1_hours': 2.5,
            'estimated_pay': 1025.50,
          }),
          200,
        ),
      );

      final week = await service.fetchWeek(
        session: session,
        employeeId: '12',
        weekStart: DateTime(2025, 11, 17),
      );

      expect(week.days, hasLength(1));
      expect(week.days.first.punches.first.source, 'mobile_app');
      expect(week.weeklyTotalHours, 38.5);
    });
  });
}

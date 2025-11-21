import 'dart:convert';

import 'package:test/test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';

import 'package:field_app_client/api/job_service.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';

class _MockHttpClient extends Mock implements http.Client {}

void main() {
  final session = AuthSession(
    token: 'token',
    expiresAt: DateTime(2099, 1, 1),
    displayName: 'Tester',
  );

  group('RestJobService', () {
    late _MockHttpClient client;
    late RestJobService service;

    setUp(() {
      client = _MockHttpClient();
      service = RestJobService(
        httpClient: client,
        baseUrl: 'https://example.com',
      );
    });

    test('parses job feed payload', () async {
      final uri = Uri.parse('https://example.com/api/mobile/jobs/12');
      when(() => client.get(uri, headers: any(named: 'headers'))).thenAnswer(
        (_) async => http.Response(
          jsonEncode({
            'employee_id': 12,
            'range': {'start': '2025-11-18', 'end': '2025-11-25'},
            'jobs': [
              {
                'job_id': 245,
                'title': '123 Main - Tear-off',
                'address': '123 Main St',
                'scheduled_date': '2025-11-21',
                'scheduled_time': '08:00',
                'services': [
                  {
                    'job_item_id': 611,
                    'service_id': 4,
                    'service_name': 'Roofing',
                    'status': 3,
                  },
                ],
                'crew': [
                  {
                    'employee_id': 12,
                    'name': 'John Doe',
                    'role': 'Installer',
                    'status': 'IN',
                  },
                ],
              },
            ],
            'api_version': '2025-11-20',
            'next_cursor': null,
          }),
          200,
        ),
      );

      final feed = await service.fetchJobs(session: session, employeeId: '12');

      expect(feed.employeeId, '12');
      expect(feed.jobs, hasLength(1));
      expect(feed.jobs.first.services.first.serviceName, 'Roofing');
      expect(feed.apiVersion, '2025-11-20');
      expect(feed.nextCursor, isNull);
    });
  });
}

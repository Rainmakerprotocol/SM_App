import 'dart:convert';

import 'package:field_app_client/config/app_config.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';
import 'package:field_app_client/offline/sync/punch_sync_transport.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

void main() {
  final session = AuthSession(
    token: 'token',
    expiresAt: DateTime(2099, 1, 1),
    displayName: 'Tester',
  );

  PunchPayload _payload(Map<String, dynamic> data) =>
      PunchPayload(queueId: 1, data: data);

  group('RestPunchSyncTransport', () {
    test('sends envelope and parses processed/duplicates/errors', () async {
      late http.Request captured;
      final client = MockClient((request) async {
        captured = request;
        return http.Response(
          jsonEncode({
            'processed': ['uuid-1'],
            'duplicates': ['uuid-2'],
            'errors': [
              {
                'uuid': 'uuid-3',
                'code': 'invalid_job',
                'message': 'Job closed',
              },
            ],
          }),
          200,
        );
      });

      final transport = RestPunchSyncTransport(
        client: client,
        baseUrl: 'https://api.example.com',
      );

      final response = await transport.send(
        session: session,
        payloads: [
          _payload({
            'mobile_uuid': 'uuid-1',
            'employee_id': '99',
            'device_id': 'device-1',
          }),
          _payload({'mobile_uuid': 'uuid-2'}),
          _payload({'mobile_uuid': 'uuid-3'}),
        ],
      );

      expect(response.processed, ['uuid-1']);
      expect(response.duplicates, ['uuid-2']);
      expect(response.errors, hasLength(1));
      expect(response.errors.first.code, 'invalid_job');

      final decoded = jsonDecode(captured.body) as Map<String, dynamic>;
      expect(decoded['punches'], hasLength(3));
      expect(decoded['employee_id'], '99');
      expect(decoded['device_id'], 'device-1');
      expect(decoded['app_version'], AppConfig.appVersionLabel);
      expect(decoded['batch_id'], isA<String>());
      expect(captured.headers['authorization'], 'Bearer ${session.token}');
      expect(captured.headers['content-type'], 'application/json');
      expect(
        captured.url.toString(),
        'https://api.example.com/api/mobile/punches/batch',
      );
    });

    test(
      'throws PunchSyncTransportException with error code mappings',
      () async {
        Future<void> _expectThrow(int status, String code) async {
          final client = MockClient((_) async => http.Response('{}', status));
          final transport = RestPunchSyncTransport(
            client: client,
            baseUrl: 'https://api.example.com',
          );
          expect(
            () => transport.send(session: session, payloads: [_payload({})]),
            throwsA(
              isA<PunchSyncTransportException>().having(
                (e) => e.code,
                'code',
                code,
              ),
            ),
          );
        }

        await _expectThrow(401, 'unauthorized');
        await _expectThrow(422, 'validation_error');
        await _expectThrow(500, 'server_error');
      },
    );
  });
}

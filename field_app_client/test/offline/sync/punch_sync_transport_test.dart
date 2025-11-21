import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

import 'package:field_app_client/modules/auth/domain/auth_models.dart';
import 'package:field_app_client/offline/sync/punch_sync_transport.dart';

void main() {
  final session = AuthSession(
    token: 'jwt-token',
    expiresAt: DateTime(2099, 1, 1),
    displayName: 'Tester',
  );

  PunchPayload _payload({String uuid = 'uuid-1'}) {
    return PunchPayload(
      queueId: 1,
      data: {
        'mobile_uuid': uuid,
        'employee_id': 12,
        'device_id': 'device-123',
        'job_id': 245,
      },
    );
  }

  test(
    'builds batch envelope with metadata and parses response lists',
    () async {
      late Map<String, dynamic> capturedBody;
      final client = MockClient((request) async {
        capturedBody = jsonDecode(request.body) as Map<String, dynamic>;
        final response = {
          'processed': ['uuid-1'],
          'duplicates': ['uuid-2'],
          'errors': [
            {'uuid': 'uuid-3', 'code': 'invalid_job', 'message': 'Job closed'},
          ],
        };
        return http.Response(jsonEncode(response), 200);
      });

      final transport = RestPunchSyncTransport(
        client: client,
        baseUrl: 'https://example.com',
      );

      final response = await transport.send(
        session: session,
        payloads: [
          _payload(uuid: 'uuid-1'),
          _payload(uuid: 'uuid-2'),
          _payload(uuid: 'uuid-3'),
        ],
      );

      expect(capturedBody['employee_id'], 12);
      expect(capturedBody['device_id'], 'device-123');
      expect((capturedBody['batch_id'] as String).endsWith('-12'), isTrue);
      expect(capturedBody['app_version'], isNotEmpty);
      expect((capturedBody['punches'] as List).length, 3);

      expect(response.processed, ['uuid-1']);
      expect(response.duplicates, ['uuid-2']);
      expect(response.errors, hasLength(1));
      expect(response.errors.first.code, 'invalid_job');
    },
  );

  test('throws transport exceptions for HTTP errors', () async {
    final mock = MockClient((request) async {
      return http.Response('unauthorized', 401);
    });

    final transport = RestPunchSyncTransport(
      client: mock,
      baseUrl: 'https://example.com',
    );

    expect(
      () => transport.send(session: session, payloads: [_payload()]),
      throwsA(
        isA<PunchSyncTransportException>().having(
          (e) => e.code,
          'code',
          'unauthorized',
        ),
      ),
    );
  });

  test('treats validation failures as transport errors', () async {
    final mock = MockClient((request) async {
      return http.Response('invalid payload', 422);
    });

    final transport = RestPunchSyncTransport(
      client: mock,
      baseUrl: 'https://example.com',
    );

    expect(
      () => transport.send(session: session, payloads: [_payload()]),
      throwsA(
        isA<PunchSyncTransportException>().having(
          (e) => e.code,
          'code',
          'validation_error',
        ),
      ),
    );
  });
}

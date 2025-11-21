import 'package:flutter_test/flutter_test.dart' as flutter_test;

import 'package:field_app_client/modules/punch/domain/punch_models.dart';

void main() {
  flutter_test.group('PunchDraft.toPayload', () {
    flutter_test.test('includes required fields plus gps when provided', () {
      final draft = PunchDraft(
        punchId: 'uuid-1',
        employeeId: '12',
        jobId: '245',
        serviceId: '611',
        type: PunchEventType.punchIn,
        timestamp: DateTime(2025, 11, 21, 8, 30),
        gps: const PunchGpsSample(lat: 43.0, lng: -83.0, accuracy: 9.5),
        deviceId: 'device-123',
        source: 'mobile_app',
        notes: 'Starting tear-off',
      );

      final payload = draft.toPayload('resolved-id');

      flutter_test.expect(payload['mobile_uuid'], 'resolved-id');
      flutter_test.expect(payload['employee_id'], '12');
      flutter_test.expect(payload['job_id'], '245');
      flutter_test.expect(payload['service_id'], '611');
      flutter_test.expect(payload['type'], 'IN');
      flutter_test.expect(payload['timestamp_device'], flutter_test.isNotEmpty);
      flutter_test.expect(payload['gps_lat'], 43.0);
      flutter_test.expect(payload['gps_lng'], -83.0);
      flutter_test.expect(payload['gps_accuracy'], 9.5);
      flutter_test.expect(payload['gps_unavailable'], false);
      flutter_test.expect(payload['device_id'], 'device-123');
      flutter_test.expect(payload['source'], 'mobile_app');
      flutter_test.expect(payload['notes'], 'Starting tear-off');
    });

    flutter_test.test('omits nullable fields when not provided', () {
      final draft = PunchDraft(
        punchId: 'uuid-2',
        employeeId: '12',
        jobId: '245',
        type: PunchEventType.punchOut,
        timestamp: DateTime(2025, 11, 21, 16, 45),
        gpsUnavailable: true,
        deviceId: 'device-123',
      );

      final payload = draft.toPayload('resolved-id');

      flutter_test.expect(payload.containsKey('service_id'), false);
      flutter_test.expect(payload.containsKey('gps_lat'), false);
      flutter_test.expect(payload.containsKey('gps_lng'), false);
      flutter_test.expect(payload.containsKey('gps_accuracy'), false);
      flutter_test.expect(payload['gps_unavailable'], true);
      flutter_test.expect(payload.containsKey('notes'), false);
    });
  });
}

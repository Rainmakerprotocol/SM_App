import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../modules/auth/domain/auth_models.dart';
import '../offline/sync/punch_sync_transport.dart';

abstract class PunchService {
  Future<PunchSyncResponse> submitBatch({
    required AuthSession session,
    required List<Map<String, dynamic>> punches,
  });
}

class RestPunchService implements PunchService {
  const RestPunchService({required this.transport});

  final PunchSyncTransport transport;

  @override
  Future<PunchSyncResponse> submitBatch({
    required AuthSession session,
    required List<Map<String, dynamic>> punches,
  }) {
    final payloads = [
      for (final punch in punches) PunchPayload(queueId: -1, data: punch),
    ];
    return transport.send(session: session, payloads: payloads);
  }
}

class MockPunchService implements PunchService {
  @override
  Future<PunchSyncResponse> submitBatch({
    required AuthSession session,
    required List<Map<String, dynamic>> punches,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    final processed = punches
        .map(
          (punch) =>
              punch['mobile_uuid']?.toString() ??
              'mock-${DateTime.now().millisecondsSinceEpoch}',
        )
        .toList();
    return PunchSyncResponse(
      processed: processed,
      duplicates: const [],
      errors: const [],
    );
  }
}

final punchServiceProvider = Provider<PunchService>((ref) {
  if (AppConfig.useMockPunchApi) {
    return MockPunchService();
  }
  return RestPunchService(transport: ref.watch(punchSyncTransportProvider));
});

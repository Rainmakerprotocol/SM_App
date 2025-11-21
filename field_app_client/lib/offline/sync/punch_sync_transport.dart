import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../../config/app_config.dart';
import '../../core/network/http_client_provider.dart';
import '../../modules/auth/domain/auth_models.dart';

class PunchPayload {
  PunchPayload({required this.queueId, required this.data});

  final int queueId;
  final Map<String, dynamic> data;

  String? get punchId =>
      data['punch_id'] as String? ?? data['mobile_uuid'] as String?;
}

class PunchSyncResponse {
  const PunchSyncResponse({
    required this.processed,
    required this.duplicates,
    required this.errors,
  });

  final List<String> processed;
  final List<String> duplicates;
  final List<PunchSyncError> errors;

  bool get hasErrors => errors.isNotEmpty;
}

class PunchSyncError {
  const PunchSyncError({
    required this.uuid,
    required this.code,
    required this.message,
  });

  final String uuid;
  final String code;
  final String message;
}

abstract class PunchSyncTransport {
  Future<PunchSyncResponse> send({
    required AuthSession session,
    required List<PunchPayload> payloads,
  });
}

class MockPunchSyncTransport implements PunchSyncTransport {
  const MockPunchSyncTransport();

  @override
  Future<PunchSyncResponse> send({
    required AuthSession session,
    required List<PunchPayload> payloads,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final ids = payloads.map((e) => e.punchId ?? 'unknown').toList();
    return PunchSyncResponse(
      processed: ids,
      duplicates: const [],
      errors: const [],
    );
  }
}

class RestPunchSyncTransport implements PunchSyncTransport {
  RestPunchSyncTransport({required this.client, required this.baseUrl})
    : assert(baseUrl.isNotEmpty, 'Base URL required');

  final http.Client client;
  final String baseUrl;

  @override
  Future<PunchSyncResponse> send({
    required AuthSession session,
    required List<PunchPayload> payloads,
  }) async {
    if (payloads.isEmpty) {
      return const PunchSyncResponse(processed: [], duplicates: [], errors: []);
    }

    final punches = [for (final payload in payloads) payload.data];
    final envelopeSeed = punches.first;
    final employeeId = envelopeSeed['employee_id'];
    final deviceId = envelopeSeed['device_id'];

    // NOTE(DL-005): Until backend overrides the punch batch schema, mobile
    // envelopes include high-level metadata plus the raw punch list so both
    // sides can validate analytics and auditing fields consistently.
    final body = <String, dynamic>{
      'batch_id': _buildBatchId(employeeId),
      'punches': punches,
      'app_version': AppConfig.appVersionLabel,
    };

    if (employeeId != null) {
      body['employee_id'] = employeeId;
    }
    if (deviceId != null) {
      body['device_id'] = deviceId;
    }

    final response = await client.post(
      Uri.parse('$baseUrl/api/mobile/punches/batch'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${session.token}',
      },
      body: jsonEncode(body),
    );

    if (response.statusCode == 401) {
      throw const PunchSyncTransportException('unauthorized');
    }

    if (response.statusCode >= 500) {
      throw const PunchSyncTransportException('server_error');
    }

    if (response.statusCode >= 400) {
      throw const PunchSyncTransportException('validation_error');
    }

    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    final processed =
        (decoded['processed'] as List?)?.cast<String>() ?? const [];
    final duplicates =
        (decoded['duplicates'] as List?)?.cast<String>() ?? const [];
    final errorsRaw = (decoded['errors'] as List?) ?? const [];
    final errors = errorsRaw.map((item) {
      if (item is Map<String, dynamic>) {
        return PunchSyncError(
          uuid: item['uuid']?.toString() ?? '',
          code: item['code']?.toString() ?? 'unknown',
          message: item['message']?.toString() ?? 'Unknown error',
        );
      }
      return const PunchSyncError(
        uuid: '',
        code: 'unknown',
        message: 'Unknown error',
      );
    }).toList();

    return PunchSyncResponse(
      processed: processed,
      duplicates: duplicates,
      errors: errors,
    );
  }
}

String _buildBatchId(Object? employeeId) {
  final ts = DateTime.now().toUtc().toIso8601String();
  final suffix = employeeId?.toString() ?? 'anon';
  return '$ts-$suffix';
}

class PunchSyncTransportException implements Exception {
  const PunchSyncTransportException(this.code);
  final String code;
}

final punchSyncTransportProvider = Provider<PunchSyncTransport>((ref) {
  if (AppConfig.useMockPunchSync) {
    return const MockPunchSyncTransport();
  }

  return RestPunchSyncTransport(
    client: ref.watch(httpClientProvider),
    baseUrl: AppConfig.apiBaseUrl,
  );
});

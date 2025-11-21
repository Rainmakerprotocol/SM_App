import 'package:meta/meta.dart';

/// Types of punch events supported in Phase 1-2 local storage.
enum PunchEventType { punchIn, punchOut, breakStart, breakEnd }

extension PunchEventTypeX on PunchEventType {
  String get storageValue {
    switch (this) {
      case PunchEventType.punchIn:
        return 'IN';
      case PunchEventType.punchOut:
        return 'OUT';
      case PunchEventType.breakStart:
        return 'BREAK_START';
      case PunchEventType.breakEnd:
        return 'BREAK_END';
    }
  }
}

@immutable
class PunchGpsSample {
  const PunchGpsSample({required this.lat, required this.lng, this.accuracy});

  final double lat;
  final double lng;
  final double? accuracy;
}

@immutable
class PunchDraft {
  const PunchDraft({
    this.punchId,
    required this.employeeId,
    required this.jobId,
    this.serviceId,
    required this.type,
    required this.timestamp,
    this.gps,
    this.gpsUnavailable = false,
    required this.deviceId,
    this.source = 'mobile_app',
    this.notes,
  });

  final String? punchId;
  final String employeeId;
  final String jobId;
  final String? serviceId;
  final PunchEventType type;
  final DateTime timestamp;
  final PunchGpsSample? gps;
  final bool gpsUnavailable;
  final String deviceId;
  final String source;
  final String? notes;

  Map<String, dynamic> toPayload(String resolvedPunchId) {
    return {
      'mobile_uuid': resolvedPunchId,
      'employee_id': employeeId,
      'job_id': jobId,
      if (serviceId != null) 'service_id': serviceId,
      'type': type.storageValue,
      'timestamp_device': timestamp.toIso8601String(),
      'gps_lat': gps?.lat,
      'gps_lng': gps?.lng,
      'gps_accuracy': gps?.accuracy,
      'gps_unavailable': gpsUnavailable,
      'device_id': deviceId,
      'source': source,
      if (notes != null) 'notes': notes,
    }..removeWhere((_, value) => value == null);
  }
}

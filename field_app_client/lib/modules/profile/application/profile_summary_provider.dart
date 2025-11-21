import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSummary {
  const ProfileSummary({
    required this.name,
    required this.employeeId,
    required this.crew,
    required this.deviceId,
    required this.osVersion,
  });

  final String name;
  final String employeeId;
  final String crew;
  final String deviceId;
  final String osVersion;
}

final profileSummaryProvider = Provider<ProfileSummary>((ref) {
  // TODO(PH1-Profile): Replace with real profile sync once backend wiring lands.
  return const ProfileSummary(
    name: 'Jamie Foreman',
    employeeId: 'EMP-204',
    crew: 'Crew 12',
    deviceId: 'mock-device-id',
    osVersion: 'Android 15',
  );
});

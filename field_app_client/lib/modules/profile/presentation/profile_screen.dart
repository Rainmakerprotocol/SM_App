import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final profileProvider = Provider<ProfileSummary>((ref) {
  return const ProfileSummary(
    name: 'Jamie Foreman',
    employeeId: 'EMP-204',
    crew: 'Crew 12',
    deviceId: 'mock-device-id',
    osVersion: 'Android 15',
  );
});

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profile = ref.watch(profileProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            leading: const CircleAvatar(child: Icon(Icons.person)),
            title: Text(profile.name),
            subtitle: Text('Employee ID: ${profile.employeeId}\nCrew: ${profile.crew}'),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            title: const Text('Device Metadata'),
            subtitle: Text(
              'Device ID: ${profile.deviceId}\nOS: ${profile.osVersion}',
            ),
          ),
        ),
        const SizedBox(height: 12),
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('Biometric unlock (coming soon)'),
        ),
        SwitchListTile(
          value: true,
          onChanged: (_) {},
          title: const Text('Share crash diagnostics'),
        ),
      ],
    );
  }
}

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

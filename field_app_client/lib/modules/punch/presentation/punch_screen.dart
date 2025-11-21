import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/punch_repository.dart';

final punchStatusProvider = Provider<PunchStatus>((ref) {
  final pendingStatsAsync = ref.watch(pendingPunchStatsProvider);
  final stats = pendingStatsAsync.maybeWhen(
    data: (value) => value,
    orElse: () => PendingPunchStats.empty,
  );
  return PunchStatus(
    isClockedIn: true,
    activeJob: 'SM-2401 · Storm Inspection',
    since: '2h 14m',
    pendingSync: stats.count,
    oldestPendingAge: stats.oldestAge(),
    gpsAccuracy: 12,
  );
});

class PunchScreen extends ConsumerWidget {
  const PunchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(punchStatusProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StatusTile(status: status),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PunchActionButton(
                label: status.isClockedIn ? 'Punch Out' : 'Punch In',
                icon: Icons.punch_clock,
                color: status.isClockedIn ? Colors.red : Colors.green,
              ),
              const _PunchActionButton(
                label: 'Break Start',
                icon: Icons.free_breakfast,
              ),
              const _PunchActionButton(label: 'Break End', icon: Icons.timer),
              const _PunchActionButton(label: 'Sync Now', icon: Icons.sync),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              title: const Text('Job Selection'),
              subtitle: Text(status.activeJob),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('GPS Accuracy'),
              subtitle: Text('${status.gpsAccuracy}m'),
              trailing: status.gpsAccuracy > 80
                  ? const Icon(Icons.warning, color: Colors.orange)
                  : const Icon(Icons.check_circle, color: Colors.green),
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({required this.status});

  final PunchStatus status;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              status.isClockedIn ? 'Currently Clocked In' : 'Clocked Out',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 4),
            Text('Active Job: ${status.activeJob}'),
            Text('Elapsed: ${status.since}'),
            const SizedBox(height: 12),
            Chip(
              label: Text(
                _pendingChipLabel(
                  count: status.pendingSync,
                  ageLabel: _formatAge(status.oldestPendingAge),
                ),
              ),
              avatar: const Icon(Icons.cloud_upload),
            ),
          ],
        ),
      ),
    );
  }
}

String _pendingChipLabel({required int count, String? ageLabel}) {
  if (ageLabel == null || ageLabel.isEmpty) {
    return 'Pending Sync: $count';
  }
  return 'Pending Sync: $count · $ageLabel';
}

class _PunchActionButton extends StatelessWidget {
  const _PunchActionButton({
    required this.label,
    required this.icon,
    this.color,
  });

  final String label;
  final IconData icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(160, 48),
        backgroundColor: color,
      ),
    );
  }
}

class PunchStatus {
  const PunchStatus({
    required this.isClockedIn,
    required this.activeJob,
    required this.since,
    required this.pendingSync,
    this.oldestPendingAge,
    required this.gpsAccuracy,
  });

  final bool isClockedIn;
  final String activeJob;
  final String since;
  final int pendingSync;
  final Duration? oldestPendingAge;
  final int gpsAccuracy;
}

String? _formatAge(Duration? age) {
  if (age == null) {
    return null;
  }
  if (age.inDays >= 1) {
    return '${age.inDays}d';
  }
  if (age.inHours >= 1) {
    return '${age.inHours}h';
  }
  if (age.inMinutes >= 1) {
    return '${age.inMinutes}m';
  }
  return '${age.inSeconds}s';
}

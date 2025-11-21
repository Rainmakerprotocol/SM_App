import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/punch_repository.dart';
import 'job_selection_context.dart';
import 'punch_action_throttle.dart';

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

  void _showSelectionSnack(BuildContext context) {
    final messenger = ScaffoldMessenger.of(context);
    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        const SnackBar(
          content: Text('Job selection flow coming soon.'),
          duration: Duration(seconds: 2),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final status = ref.watch(punchStatusProvider);
    final jobContext = ref.watch(jobSelectionContextProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _StatusTile(status: status, jobContext: jobContext),
          const SizedBox(height: 16),
          if (!jobContext.hasSelection)
            _JobSelectionReminder(onSelect: () => _showSelectionSnack(context))
          else
            _CrewContextChips(crew: jobContext.crewMembers),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PunchActionButton(
                label: status.isClockedIn ? 'Punch Out' : 'Punch In',
                icon: Icons.punch_clock,
                color: status.isClockedIn ? Colors.red : Colors.green,
                actionKey: 'punch-primary',
                enabled: jobContext.hasSelection,
              ),
              _PunchActionButton(
                label: 'Break Start',
                icon: Icons.free_breakfast,
                actionKey: 'break-start',
                enabled: jobContext.hasSelection,
              ),
              _PunchActionButton(
                label: 'Break End',
                icon: Icons.timer,
                actionKey: 'break-end',
                enabled: jobContext.hasSelection,
              ),
              _PunchActionButton(
                label: 'Sync Now',
                icon: Icons.sync,
                actionKey: 'sync-now',
                enabled: jobContext.hasSelection,
              ),
            ],
          ),
          const SizedBox(height: 24),
          Card(
            child: ListTile(
              title: const Text('Job Selection'),
              subtitle: jobContext.hasSelection
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(jobContext.jobLabel ?? 'Select a job'),
                        if (jobContext.serviceLabel != null)
                          Text(
                            jobContext.serviceLabel!,
                            style: Theme.of(context).textTheme.bodySmall
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                      ],
                    )
                  : const Text('Select a job to unlock punch actions'),
              trailing: TextButton.icon(
                onPressed: () => _showSelectionSnack(context),
                icon: const Icon(Icons.search),
                label: const Text('Select job'),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: ListTile(
              title: const Text('GPS Accuracy'),
              subtitle: GpsQualityIndicator(status: status),
            ),
          ),
        ],
      ),
    );
  }
}

class GpsQualityIndicator extends StatelessWidget {
  const GpsQualityIndicator({super.key, required this.status});

  final PunchStatus status;

  @override
  Widget build(BuildContext context) {
    final quality = _qualityForAccuracy(status.gpsAccuracy);
    final color = _qualityColor(quality);
    final tooltip = _qualityTooltip(quality);

    return Tooltip(
      message: tooltip,
      child: Row(
        children: [
          Icon(_qualityIcon(quality), color: color),
          const SizedBox(width: 8),
          Text('${status.gpsAccuracy}m • ${quality.label}'),
        ],
      ),
    );
  }
}

class _JobSelectionReminder extends StatelessWidget {
  const _JobSelectionReminder({required this.onSelect});

  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        children: [
          const Icon(Icons.assignment_late, color: Colors.orange),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Select a job/service before submitting punches.',
              style: TextStyle(color: Colors.orange),
            ),
          ),
          TextButton(onPressed: onSelect, child: const Text('Select Job')),
        ],
      ),
    );
  }
}

class _CrewContextChips extends StatelessWidget {
  const _CrewContextChips({required this.crew});

  final List<CrewMemberSummary> crew;

  @override
  Widget build(BuildContext context) {
    if (crew.isEmpty) {
      return const SizedBox.shrink();
    }
    return Material(
      color: Colors.transparent,
      child: Wrap(
        spacing: 8,
        runSpacing: 4,
        children: [
          for (final member in crew)
            Chip(label: Text('${member.name} · ${member.role}')),
        ],
      ),
    );
  }
}

enum _GpsQuality { good, fair, poor }

extension on _GpsQuality {
  String get label {
    switch (this) {
      case _GpsQuality.good:
        return 'Strong';
      case _GpsQuality.fair:
        return 'Moderate';
      case _GpsQuality.poor:
        return 'Weak';
    }
  }
}

_GpsQuality _qualityForAccuracy(int meters) {
  if (meters <= 20) {
    return _GpsQuality.good;
  }
  if (meters <= 80) {
    return _GpsQuality.fair;
  }
  return _GpsQuality.poor;
}

Color _qualityColor(_GpsQuality quality) {
  switch (quality) {
    case _GpsQuality.good:
      return Colors.green;
    case _GpsQuality.fair:
      return Colors.orange;
    case _GpsQuality.poor:
      return Colors.red;
  }
}

IconData _qualityIcon(_GpsQuality quality) {
  switch (quality) {
    case _GpsQuality.good:
      return Icons.gps_fixed;
    case _GpsQuality.fair:
      return Icons.gps_not_fixed;
    case _GpsQuality.poor:
      return Icons.gps_off;
  }
}

String _qualityTooltip(_GpsQuality quality) {
  switch (quality) {
    case _GpsQuality.good:
      return 'High accuracy; punch is good to go.';
    case _GpsQuality.fair:
      return 'Moderate accuracy; step outside for a better lock if possible.';
    case _GpsQuality.poor:
      return 'Weak GPS; try moving to an open area for a stronger fix.';
  }
}

class _StatusTile extends StatelessWidget {
  const _StatusTile({required this.status, required this.jobContext});

  final PunchStatus status;
  final JobSelectionContext jobContext;

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
            Text(
              jobContext.hasSelection
                  ? 'Active Job: ${jobContext.jobLabel ?? status.activeJob}'
                  : 'No job selected',
            ),
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

class _PunchActionButton extends ConsumerWidget {
  const _PunchActionButton({
    required this.label,
    required this.icon,
    required this.actionKey,
    this.color,
    this.enabled = true,
  });

  final String label;
  final IconData icon;
  final String actionKey;
  final Color? color;
  final bool enabled;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isCooling = ref.watch(
      punchActionThrottleProvider.select(
        (cooldowns) => cooldowns.contains(actionKey),
      ),
    );
    final messenger = ScaffoldMessenger.of(context);

    final canTap = enabled && !isCooling;

    return ElevatedButton.icon(
      key: ValueKey('punch-action-$actionKey'),
      onPressed: canTap
          ? () {
              final accepted = ref
                  .read(punchActionThrottleProvider.notifier)
                  .tryTrigger(actionKey);
              if (!accepted) {
                return;
              }
              messenger
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  SnackBar(
                    content: Text('$label tapped (placeholder action)'),
                    duration: const Duration(seconds: 2),
                  ),
                );
            }
          : null,
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

  PunchStatus copyWith({int? gpsAccuracy}) {
    return PunchStatus(
      isClockedIn: isClockedIn,
      activeJob: activeJob,
      since: since,
      pendingSync: pendingSync,
      oldestPendingAge: oldestPendingAge,
      gpsAccuracy: gpsAccuracy ?? this.gpsAccuracy,
    );
  }
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

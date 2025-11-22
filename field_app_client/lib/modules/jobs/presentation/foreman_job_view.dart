import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/foreman_job_controller.dart';

class ForemanJobsPane extends ConsumerWidget {
  const ForemanJobsPane({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(foremanJobsProvider);

    return jobsAsync.when(
      data: (jobs) {
        if (jobs.isEmpty) {
          return const SizedBox.shrink();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 24),
            Text(
              'Foreman Window (±14 days)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Text(
              'Track crew punches, unsynced work, and off-assignment alerts for your jobs.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            const SizedBox(height: 12),
            for (final job in jobs) ...[
              _ForemanJobCard(entry: job),
              const SizedBox(height: 12),
            ],
          ],
        );
      },
      loading: () => const _ForemanLoadingCard(),
      error: (error, _) => _ForemanErrorCard(message: error.toString()),
    );
  }
}

class _ForemanJobCard extends StatelessWidget {
  const _ForemanJobCard({required this.entry});

  final ForemanJobEntry entry;

  @override
  Widget build(BuildContext context) {
    final scheduleLabel = _formatSchedule(context, entry.scheduledDate);
    final updatedLabel = _formatRelative(entry.lastUpdated);
    final statusColor = entry.isPastDue ? Colors.red[100] : Colors.green[50];
    final unsyncedLabel = entry.unsyncedPunchCount == 0
        ? 'All punches synced'
        : '${entry.unsyncedPunchCount} unsynced punch${entry.unsyncedPunchCount == 1 ? '' : 'es'}';

    return Card(
      child: ExpansionTile(
        tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        childrenPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        title: Text(entry.customerName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (entry.address != null)
              Text(
                entry.address!,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            Text(
              '$scheduleLabel · Service ${entry.serviceId}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (updatedLabel != null)
              Text(
                'Feed updated $updatedLabel',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                unsyncedLabel,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: entry.unsyncedPunchCount == 0
                      ? Colors.green[800]
                      : Colors.red[800],
                ),
              ),
            ),
          ],
        ),
        children: [
          if (!entry.hasCrew)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'No crew roster on file for this job.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            )
          else
            Column(
              children: [
                for (final crewMember in entry.crew)
                  _CrewStatusTile(job: entry, status: crewMember),
              ],
            ),
        ],
      ),
    );
  }
}

class _CrewStatusTile extends StatelessWidget {
  const _CrewStatusTile({required this.job, required this.status});

  final ForemanJobEntry job;
  final CrewAssignmentStatus status;

  @override
  Widget build(BuildContext context) {
    final presenceLabel = _presenceLabel(status.presence);
    final presenceColor = _presenceColor(status.presence, context);
    final currentJobLabel = status.currentJobId?.isNotEmpty == true
        ? status.currentJobId
        : 'No punches logged';
    final relativePunch = _formatRelative(status.lastPunchAt);
    final badgeLabel = status.source == 'job_clock' ? 'Job Clock' : 'Mobile';
    final badgeColor = status.source == 'job_clock'
        ? Colors.indigo[100]
        : Colors.teal[100];

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 4),
      title: Text(status.name, style: Theme.of(context).textTheme.titleSmall),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (status.role != null) Text(status.role!),
          Row(
            children: [
              Chip(
                label: Text(presenceLabel),
                backgroundColor: presenceColor,
                visualDensity: VisualDensity.compact,
              ),
              const SizedBox(width: 6),
              Chip(
                label: Text(badgeLabel),
                backgroundColor: badgeColor,
                visualDensity: VisualDensity.compact,
              ),
              if (status.hasUnsyncedPunches) ...[
                const SizedBox(width: 6),
                Chip(
                  label: const Text('Unsynced'),
                  backgroundColor: Colors.orange[100],
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ],
          ),
          Text(
            'Current job: $currentJobLabel'
            '${status.isOffAssignment ? ' (Off assignment)' : ''}',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          if (relativePunch != null)
            Text(
              'Last punch $relativePunch',
              style: Theme.of(
                context,
              ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
            ),
        ],
      ),
      trailing: IconButton(
        tooltip: 'Crew drill-down',
        icon: const Icon(Icons.info_outline),
        onPressed: () => _showCrewDetail(context, job, status),
      ),
    );
  }
}

class _ForemanLoadingCard extends StatelessWidget {
  const _ForemanLoadingCard();

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class _ForemanErrorCard extends StatelessWidget {
  const _ForemanErrorCard({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Foreman data unavailable',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 4),
        Text(message, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}

void _showCrewDetail(
  BuildContext context,
  ForemanJobEntry job,
  CrewAssignmentStatus status,
) {
  showModalBottomSheet<void>(
    context: context,
    builder: (ctx) {
      final relativePunch = _formatRelative(status.lastPunchAt);
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(status.name, style: Theme.of(ctx).textTheme.titleLarge),
              if (status.role != null) ...[
                const SizedBox(height: 4),
                Text(status.role!, style: Theme.of(ctx).textTheme.bodySmall),
              ],
              const SizedBox(height: 12),
              Text('Assigned job: ${job.jobId}'),
              Text(
                'Last punch job: ${status.currentJobId ?? 'No punches recorded'}',
              ),
              const SizedBox(height: 12),
              Text(
                'Punch source: ${status.source == 'job_clock' ? 'Job clock' : 'Mobile app'}',
              ),
              if (relativePunch != null) Text('Last punch: $relativePunch'),
              const SizedBox(height: 12),
              Text('Backend status: ${status.backendStatus}'),
              if (status.hasUnsyncedPunches)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    'Warning: Unsynced punches will be submitted when connectivity returns.',
                    style: Theme.of(
                      ctx,
                    ).textTheme.bodySmall?.copyWith(color: Colors.orange[800]),
                  ),
                ),
            ],
          ),
        ),
      );
    },
  );
}

Color? _presenceColor(CrewPresenceState presence, BuildContext context) {
  switch (presence) {
    case CrewPresenceState.clockedIn:
      return Colors.green[100];
    case CrewPresenceState.clockedOut:
      return Colors.blueGrey[100];
    case CrewPresenceState.breakActive:
      return Colors.amber[100];
    case CrewPresenceState.unknown:
      return Theme.of(context).colorScheme.surfaceContainerHighest;
  }
}

String _presenceLabel(CrewPresenceState presence) {
  switch (presence) {
    case CrewPresenceState.clockedIn:
      return 'Clocked In';
    case CrewPresenceState.clockedOut:
      return 'Clocked Out';
    case CrewPresenceState.breakActive:
      return 'On Break';
    case CrewPresenceState.unknown:
      return 'Unknown';
  }
}

String _formatSchedule(BuildContext context, DateTime date) {
  final dayLabel = '${date.month}/${date.day}/${date.year}';
  final timeOfDay = TimeOfDay.fromDateTime(date);
  final timeLabel = MaterialLocalizations.of(
    context,
  ).formatTimeOfDay(timeOfDay);
  return '$dayLabel · $timeLabel';
}

String? _formatRelative(DateTime? timestamp) {
  if (timestamp == null) {
    return null;
  }
  final now = DateTime.now();
  final diff = now.difference(timestamp);
  if (diff.inSeconds < 60) {
    return 'just now';
  }
  if (diff.inMinutes < 60) {
    return '${diff.inMinutes}m ago';
  }
  if (diff.inHours < 24) {
    return '${diff.inHours}h ago';
  }
  return '${diff.inDays}d ago';
}

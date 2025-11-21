import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../application/job_list_controller.dart';

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bucketsAsync = ref.watch(jobBucketsProvider);
    final feedStatus = ref
        .watch(jobFeedStatusProvider)
        .maybeWhen(data: (status) => status, orElse: () => null);

    return RefreshIndicator(
      onRefresh: () => _handleRefresh(context, ref),
      child: bucketsAsync.when(
        data: (buckets) =>
            _JobListView(buckets: buckets, feedStatus: feedStatus),
        loading: () => const _LoadingList(),
        error: (error, stack) => _ErrorList(message: error.toString()),
      ),
    );
  }

  Future<void> _handleRefresh(BuildContext context, WidgetRef ref) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(jobListRefresherProvider).refresh();
    } on JobRefreshException catch (error) {
      messenger.showSnackBar(
        SnackBar(
          content: Text(error.message),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }
}

class _JobListView extends StatelessWidget {
  const _JobListView({required this.buckets, required this.feedStatus});

  final JobListBuckets buckets;
  final JobFeedStatus? feedStatus;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      children: [
        _FeedStatusCard(status: feedStatus),
        const SizedBox(height: 16),
        _JobSection(title: "Today's Jobs", jobs: buckets.today),
        const SizedBox(height: 24),
        _JobSection(title: 'This Week', jobs: buckets.thisWeek),
        const SizedBox(height: 24),
        _JobSection(title: 'Last Week', jobs: buckets.lastWeek),
        if (buckets.isEmpty)
          const Padding(
            padding: EdgeInsets.only(top: 32),
            child: _EmptyState(),
          ),
      ],
    );
  }
}

class _FeedStatusCard extends StatelessWidget {
  const _FeedStatusCard({required this.status});

  final JobFeedStatus? status;

  @override
  Widget build(BuildContext context) {
    final lastLabel = _formatRelative(status?.lastRefreshed);
    final range = _formatRange(status);
    final apiVersion = status?.apiVersion;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Job Feed', style: Theme.of(context).textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              lastLabel ?? 'No sync recorded yet',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (range != null) ...[
              const SizedBox(height: 4),
              Text(range, style: Theme.of(context).textTheme.bodySmall),
            ],
            if (apiVersion != null) ...[
              const SizedBox(height: 4),
              Text(
                'API version: $apiVersion',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ],
        ),
      ),
    );
  }

  String? _formatRange(JobFeedStatus? status) {
    if (status?.rangeStart == null || status?.rangeEnd == null) {
      return null;
    }
    final start = status!.rangeStart!;
    final end = status.rangeEnd!;
    return 'Range: ${_formatDate(start)} - ${_formatDate(end)}';
  }
}

class _JobSection extends StatelessWidget {
  const _JobSection({required this.title, required this.jobs});

  final String title;
  final List<JobListEntry> jobs;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        if (jobs.isEmpty)
          Text(
            'No jobs in this bucket.',
            style: Theme.of(context).textTheme.bodySmall,
          )
        else
          Column(
            children: [
              for (final job in jobs) ...[
                _JobCard(job: job),
                const SizedBox(height: 12),
              ],
            ],
          ),
      ],
    );
  }
}

class _JobCard extends StatelessWidget {
  const _JobCard({required this.job});

  final JobListEntry job;

  @override
  Widget build(BuildContext context) {
    final timeOfDay = TimeOfDay.fromDateTime(job.scheduledDate);
    final timeLabel = MaterialLocalizations.of(
      context,
    ).formatTimeOfDay(timeOfDay);
    final dateLabel = _formatDate(job.scheduledDate);
    final updatedLabel = _formatRelative(job.lastUpdated);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        job.title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      if (job.address != null)
                        Text(
                          job.address!,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      Text(
                        'Job ${job.jobId} • Service ${job.serviceId}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      dateLabel,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                    Text(
                      timeLabel,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (job.hasCrew)
              Wrap(
                spacing: 8,
                runSpacing: 4,
                children: [
                  for (final member in job.crewNames.take(6))
                    Chip(label: Text(member)),
                  if (job.crewNames.length > 6)
                    Chip(label: Text('+${job.crewNames.length - 6} more')),
                ],
              )
            else
              Text(
                'Crew roster pending',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            const SizedBox(height: 8),
            if (updatedLabel != null)
              Text(
                'Updated $updatedLabel',
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
              ),
          ],
        ),
      ),
    );
  }
}

class _LoadingList extends StatelessWidget {
  const _LoadingList();

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: const [
        SizedBox(height: 200),
        Center(child: CircularProgressIndicator()),
      ],
    );
  }
}

class _ErrorList extends StatelessWidget {
  const _ErrorList({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(32),
      children: [
        Icon(
          Icons.warning_amber_rounded,
          size: 48,
          color: Theme.of(context).colorScheme.error,
        ),
        const SizedBox(height: 16),
        Text(
          'Unable to load jobs',
          style: Theme.of(context).textTheme.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        Text(
          message,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Icon(Icons.work_outline, size: 40, color: Colors.grey),
        const SizedBox(height: 8),
        Text(
          'No jobs synced yet. Pull to refresh to fetch assignments.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
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

String _formatDate(DateTime date) {
  final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  final weekday = weekdays[(date.weekday - 1).clamp(0, 6)];
  return '$weekday ${date.month}/${date.day}';
}

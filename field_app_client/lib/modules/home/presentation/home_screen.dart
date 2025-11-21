import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final homeSummaryProvider = Provider<HomeSummary>((ref) {
  return const HomeSummary(
    pendingSyncCount: 3,
    lastPunch: 'Today · 7:45 AM',
    gpsHealth: 'Good',
  );
});

final upcomingJobsProvider = Provider<List<String>>((ref) {
  return const [
    'Crew 12 · Storm Inspection',
    'Crew 05 · Roof Dry-In',
    'Crew 09 · Final QC',
  ];
});

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(homeSummaryProvider);
    final jobs = ref.watch(upcomingJobsProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Sync Queue', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 4),
                Text('${summary.pendingSyncCount} punches waiting to upload'),
                const SizedBox(height: 12),
                Text('Last Punch: ${summary.lastPunch}'),
                Text('GPS Status: ${summary.gpsHealth}'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text('Upcoming Jobs', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        for (final job in jobs)
          Card(
            child: ListTile(
              title: Text(job),
              subtitle: const Text('Window: ±14 days'),
              trailing: const Icon(Icons.chevron_right),
            ),
          ),
      ],
    );
  }
}

class HomeSummary {
  const HomeSummary({
    required this.pendingSyncCount,
    required this.lastPunch,
    required this.gpsHealth,
  });

  final int pendingSyncCount;
  final String lastPunch;
  final String gpsHealth;
}

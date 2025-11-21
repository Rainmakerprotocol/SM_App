import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final jobFeedProvider = Provider<List<JobSummary>>((ref) {
  return const [
    JobSummary(
      jobCode: 'SM-2401',
      description: 'School reroof phase 1',
      location: 'Pensacola, FL',
      crewCount: 8,
      hasOpenTasks: true,
    ),
    JobSummary(
      jobCode: 'SM-2408',
      description: 'Retail build-back',
      location: 'Destin, FL',
      crewCount: 5,
      hasOpenTasks: false,
    ),
    JobSummary(
      jobCode: 'SM-2410',
      description: 'Emergency tarp',
      location: 'Panama City, FL',
      crewCount: 2,
      hasOpenTasks: true,
    ),
  ];
});

class JobListScreen extends ConsumerWidget {
  const JobListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobs = ref.watch(jobFeedProvider);

    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: jobs.length,
      separatorBuilder: (context, _) => const SizedBox(height: 8),
      itemBuilder: (context, index) {
        final job = jobs[index];
        return Card(
          child: ListTile(
            leading: CircleAvatar(child: Text(job.jobCode.split('-').last)),
            title: Text(job.description),
            subtitle: Text('${job.location} · Crew ${job.crewCount}'),
            trailing: job.hasOpenTasks
                ? Chip(
                    label: const Text('Action Needed'),
                    backgroundColor:
                        Theme.of(context).colorScheme.errorContainer,
                    labelStyle: TextStyle(
                      color: Theme.of(context).colorScheme.onErrorContainer,
                    ),
                  )
                : const Icon(Icons.check_circle, color: Colors.green),
          ),
        );
      },
    );
  }
}

class JobSummary {
  const JobSummary({
    required this.jobCode,
    required this.description,
    required this.location,
    required this.crewCount,
    required this.hasOpenTasks,
  });

  final String jobCode;
  final String description;
  final String location;
  final int crewCount;
  final bool hasOpenTasks;
}

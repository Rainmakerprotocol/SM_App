import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final timesheetProvider = Provider<List<TimesheetEntry>>((ref) {
  return const [
    TimesheetEntry(day: 'Mon', hours: 9.0, job: 'SM-2401'),
    TimesheetEntry(day: 'Tue', hours: 8.5, job: 'SM-2401'),
    TimesheetEntry(day: 'Wed', hours: 8.0, job: 'SM-2408'),
    TimesheetEntry(day: 'Thu', hours: 10.0, job: 'SM-2408'),
    TimesheetEntry(day: 'Fri', hours: 6.5, job: 'Training'),
  ];
});

class TimesheetScreen extends ConsumerWidget {
  const TimesheetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final entries = ref.watch(timesheetProvider);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: ListTile(
            title: const Text('Week Total'),
            subtitle: Text('${_totalHours(entries).toStringAsFixed(1)} hrs'),
            trailing: const Icon(Icons.summarize),
          ),
        ),
        const SizedBox(height: 12),
        for (final entry in entries)
          Card(
            child: ListTile(
              leading: CircleAvatar(child: Text(entry.day)),
              title: Text('${entry.hours.toStringAsFixed(1)} hrs'),
              subtitle: Text(entry.job),
              trailing: const Icon(Icons.receipt_long),
            ),
          ),
      ],
    );
  }

  double _totalHours(List<TimesheetEntry> entries) {
    return entries.fold(0, (sum, item) => sum + item.hours);
  }
}

class TimesheetEntry {
  const TimesheetEntry({
    required this.day,
    required this.hours,
    required this.job,
  });

  final String day;
  final double hours;
  final String job;
}

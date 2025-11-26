import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../offline/database/app_database.dart';
import '../../auth/application/auth_controller.dart';
import '../domain/timesheet_aggregator.dart';
import 'timesheet_controller.dart';

final selectedWeekProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  // Start of week (Monday)
  return DateTime(now.year, now.month, now.day).subtract(Duration(days: now.weekday - 1));
});

class TimesheetScreen extends ConsumerWidget {
  const TimesheetScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weekStart = ref.watch(selectedWeekProvider);
    final timesheetsAsync = ref.watch(timesheetControllerProvider(weekStart));
    final session = ref.watch(authSessionProvider);
    
    // Watch flags for the week
    final flagsAsync = session != null 
        ? ref.watch(timesheetFlagsProvider(TimesheetFlagsRequest(session.employeeId, weekStart)))
        : const AsyncValue.data(<TimesheetFlagsLocalData>[]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Timesheets'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () async {
              final picked = await showDatePicker(
                context: context,
                initialDate: weekStart,
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              );
              if (picked != null) {
                // Align to Monday
                final newStart = picked.subtract(Duration(days: picked.weekday - 1));
                ref.read(selectedWeekProvider.notifier).state = 
                    DateTime(newStart.year, newStart.month, newStart.day);
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () async {
              final session = ref.read(authSessionProvider);
              if (session != null) {
                await ref.read(timesheetAggregatorProvider).aggregateWeek(session.employeeId, weekStart);
              }
            },
          ),
        ],
      ),
      body: Column(
        children: [
          _WeekHeader(weekStart: weekStart),
          // Warning Banner
          flagsAsync.when(
            data: (flags) {
              if (flags.isEmpty) return const SizedBox.shrink();
              final errorCount = flags.where((f) => f.severity == 'error').length;
              final warningCount = flags.where((f) => f.severity == 'warning').length;
              
              return Container(
                color: Theme.of(context).colorScheme.errorContainer,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Icon(Icons.warning_amber, color: Theme.of(context).colorScheme.onErrorContainer),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        '$errorCount Errors, $warningCount Warnings found',
                        style: TextStyle(color: Theme.of(context).colorScheme.onErrorContainer),
                      ),
                    ),
                  ],
                ),
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
          Expanded(
            child: timesheetsAsync.when(
              data: (timesheets) {
                if (timesheets.isEmpty) {
                  return const Center(
                    child: Text('No timesheets found. Pull to refresh.'),
                  );
                }
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    _WeeklySummaryCard(timesheets: timesheets),
                    const SizedBox(height: 12),
                    ...timesheets.map((t) {
                      // Find flags for this day
                      final dayFlags = flagsAsync.valueOrNull?.where((f) => 
                        f.date.year == t.date.year && 
                        f.date.month == t.date.month && 
                        f.date.day == t.date.day
                      ).toList() ?? [];
                      
                      return _DailyTimesheetCard(timesheet: t, flags: dayFlags);
                    }),
                  ],
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('Error: $err')),
            ),
          ),
        ],
      ),
    );
  }
}

class _WeekHeader extends StatelessWidget {
  const _WeekHeader({required this.weekStart});
  final DateTime weekStart;

  @override
  Widget build(BuildContext context) {
    final end = weekStart.add(const Duration(days: 6));
    final fmt = DateFormat('MMM d');
    return Container(
      padding: const EdgeInsets.all(16),
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Week of ${fmt.format(weekStart)} - ${fmt.format(end)}',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ],
      ),
    );
  }
}

class _WeeklySummaryCard extends StatelessWidget {
  const _WeeklySummaryCard({required this.timesheets});
  final List<TimesheetLocalData> timesheets;

  @override
  Widget build(BuildContext context) {
    // Assuming all rows have the same weekly totals (denormalized)
    final first = timesheets.first;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Weekly Total'),
                Text(
                  '${first.weeklyTotalHours.toStringAsFixed(2)} hrs',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Regular: ${first.weeklyTotalHours - first.weeklyOt1Hours}'),
                Text('OT: ${first.weeklyOt1Hours}'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Est. Pay'),
                Text(
                  '\$${first.estimatedPay.toStringAsFixed(2)}',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DailyTimesheetCard extends StatelessWidget {
  const _DailyTimesheetCard({required this.timesheet, required this.flags});
  final TimesheetLocalData timesheet;
  final List<TimesheetFlagsLocalData> flags;

  @override
  Widget build(BuildContext context) {
    final fmt = DateFormat('E, MMM d');
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          child: Text(DateFormat('E').format(timesheet.date).substring(0, 1)),
        ),
        title: Text(fmt.format(timesheet.date)),
        subtitle: Text('Reg: ${timesheet.regularHours} | OT: ${timesheet.otHours}'),
        trailing: Text(
          '${(timesheet.regularHours + timesheet.otHours).toStringAsFixed(2)} hrs',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Reg: ${timesheet.regularHours} | OT: ${timesheet.otHours}'),
            if (flags.isNotEmpty) ...[
              const SizedBox(height: 4),
              ...flags.map((f) => Text(
                '• ${f.message}',
                style: TextStyle(
                  color: f.severity == 'error' ? Colors.red : Colors.orange,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              )),
            ],
          ],
        ),
      ),
    );
  }
}

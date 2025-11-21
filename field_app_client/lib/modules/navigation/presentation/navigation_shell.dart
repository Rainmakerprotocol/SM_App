import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_controller.dart';
import '../../home/presentation/home_screen.dart';
import '../../jobs/presentation/job_list_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../punch/data/punch_repository.dart';
import '../../punch/presentation/punch_screen.dart';
import '../../timesheet/presentation/timesheet_screen.dart';
import '../../../offline/offline_status.dart';
import '../../../offline/sync/queue_alerts.dart';
import '../../../offline/sync/sync_feedback.dart';
import '../../../offline/sync/sync_manager.dart';
import '../../../offline/sync/sync_providers.dart';
import '../../../offline/sync/sync_state.dart';

final _currentTabProvider = StateProvider<int>((ref) => 0);

class NavigationShell extends ConsumerWidget {
  const NavigationShell({super.key, this.displayName = ''});

  final String displayName;

  static final _tabs = [
    _TabDestination(
      label: 'Home',
      icon: Icons.dashboard_outlined,
      selectedIcon: Icons.dashboard,
      builder: HomeScreen.new,
    ),
    _TabDestination(
      label: 'Jobs',
      icon: Icons.work_outline,
      selectedIcon: Icons.work,
      builder: JobListScreen.new,
    ),
    _TabDestination(
      label: 'Punch',
      icon: Icons.punch_clock_outlined,
      selectedIcon: Icons.punch_clock,
      builder: PunchScreen.new,
    ),
    _TabDestination(
      label: 'Timesheet',
      icon: Icons.calendar_today_outlined,
      selectedIcon: Icons.calendar_today,
      builder: TimesheetScreen.new,
    ),
    _TabDestination(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
      builder: ProfileScreen.new,
    ),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(_currentTabProvider);
    final controller = ref.read(authControllerProvider.notifier);
    final syncManager = ref.read(syncManagerProvider);
    final offlineStatus = ref.watch(offlineStatusProvider);
    final lastSync = ref.watch(lastSuccessfulSyncProvider);
    final pendingStatsAsync = ref.watch(pendingPunchStatsProvider);
    final pendingStats = pendingStatsAsync.maybeWhen(
      data: (value) => value,
      orElse: () => PendingPunchStats.empty,
    );

    ref.listen<AsyncValue<SyncFeedback>>(syncFeedbackStreamProvider, (
      prev,
      next,
    ) {
      next.whenData((feedback) {
        if (feedback.type == SyncFeedbackType.success) {
          return;
        }
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(
          SnackBar(
            content: Text(feedback.buildMessage()),
            backgroundColor: feedback.type == SyncFeedbackType.partialFailure
                ? Colors.orange
                : Colors.red,
            behavior: SnackBarBehavior.floating,
            duration: const Duration(seconds: 4),
          ),
        );
      });
    });

    ref.listen<AsyncValue<QueueAlert>>(queueAlertStreamProvider, (prev, next) {
      next.whenData((alert) {
        final messenger = ScaffoldMessenger.of(context);
        messenger.clearSnackBars();
        messenger.showSnackBar(
          SnackBar(
            content: Text(alert.message),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
          ),
        );
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[currentIndex].label),
        actions: [
          IconButton(
            tooltip: 'Sync now',
            onPressed: () => syncManager.trigger(SyncTrigger.explicit),
            icon: const Icon(Icons.sync),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: controller.signOut,
            icon: const Icon(Icons.logout),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(24),
          child: Column(
            children: [
              Text(
                'Welcome ${displayName.isEmpty ? 'Crew Member' : displayName}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 4),
              _ConnectivityBadge(
                isOnline: offlineStatus.hasConnectivity,
                lastSync: lastSync,
              ),
              if (!offlineStatus.hasConnectivity) ...[
                const SizedBox(height: 4),
                const OfflineWarningBanner(),
              ],
              if (pendingStats.count > 0) ...[
                const SizedBox(height: 4),
                _UnsyncedBanner(stats: pendingStats),
              ],
              const SizedBox(height: 8),
            ],
          ),
        ),
      ),
      body: IndexedStack(
        index: currentIndex,
        children: [for (final tab in _tabs) tab.builder()],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        destinations: [
          for (final tab in _tabs)
            NavigationDestination(
              icon: Icon(tab.icon),
              selectedIcon: Icon(tab.selectedIcon),
              label: tab.label,
            ),
        ],
        onDestinationSelected: (index) =>
            ref.read(_currentTabProvider.notifier).state = index,
      ),
    );
  }
}

class OfflineWarningBanner extends StatelessWidget {
  const OfflineWarningBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.orange[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.orange.shade200),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(Icons.signal_wifi_connected_no_internet_4, color: Colors.orange),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'You are offline. Punches will sync when connection is restored.',
              style: TextStyle(color: Colors.orange),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnsyncedBanner extends StatelessWidget {
  const _UnsyncedBanner({required this.stats});

  final PendingPunchStats stats;

  @override
  Widget build(BuildContext context) {
    final ageLabel = _formatUnsyncedAge(stats.oldestAge());
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.warning_amber_rounded, size: 16, color: Colors.orange),
        const SizedBox(width: 6),
        Text(
          'Unsynced punches: ${stats.count}${ageLabel != null ? ' · Oldest $ageLabel' : ''}',
          style: Theme.of(
            context,
          ).textTheme.bodySmall?.copyWith(color: Colors.orange[800]),
        ),
      ],
    );
  }
}

String? _formatUnsyncedAge(Duration? age) {
  if (age == null) {
    return null;
  }
  if (age.inDays >= 1) {
    return '${age.inDays}d old';
  }
  if (age.inHours >= 1) {
    return '${age.inHours}h old';
  }
  if (age.inMinutes >= 1) {
    return '${age.inMinutes}m old';
  }
  return '${age.inSeconds}s old';
}

class _ConnectivityBadge extends StatelessWidget {
  const _ConnectivityBadge({required this.isOnline, required this.lastSync});

  final bool isOnline;
  final DateTime? lastSync;

  @override
  Widget build(BuildContext context) {
    final color = isOnline ? Colors.green : Colors.red;
    final label = isOnline ? 'Online' : 'Offline';
    final subtitle = _formatLastSync(lastSync);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(isOnline ? Icons.wifi : Icons.wifi_off, size: 16, color: color),
        const SizedBox(width: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
        if (subtitle != null) ...[
          const SizedBox(width: 8),
          Text(
            subtitle,
            style: Theme.of(
              context,
            ).textTheme.bodySmall?.copyWith(color: Colors.grey[600]),
          ),
        ],
      ],
    );
  }
}

String? _formatLastSync(DateTime? timestamp) {
  if (timestamp == null) {
    return null;
  }
  final now = DateTime.now();
  final diff = now.difference(timestamp);
  if (diff.inSeconds < 60) {
    return 'Synced just now';
  }
  if (diff.inMinutes < 60) {
    return 'Last sync ${diff.inMinutes}m ago';
  }
  if (diff.inHours < 24) {
    return 'Last sync ${diff.inHours}h ago';
  }
  return 'Last sync ${diff.inDays}d ago';
}

class _TabDestination {
  const _TabDestination({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    required this.builder,
  });

  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final Widget Function() builder;
}

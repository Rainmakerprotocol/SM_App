import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_controller.dart';
import '../../home/presentation/home_screen.dart';
import '../../jobs/presentation/job_list_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../punch/presentation/punch_screen.dart';
import '../../timesheet/presentation/timesheet_screen.dart';
import '../../../offline/offline_status.dart';
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

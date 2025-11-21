import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../auth/application/auth_controller.dart';
import '../../home/presentation/home_screen.dart';
import '../../jobs/presentation/job_list_screen.dart';
import '../../profile/presentation/profile_screen.dart';
import '../../punch/presentation/punch_screen.dart';
import '../../timesheet/presentation/timesheet_screen.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: Text(_tabs[currentIndex].label),
        actions: [
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

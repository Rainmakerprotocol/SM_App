import 'package:field_app_client/modules/punch/presentation/job_selection_context.dart';
import 'package:field_app_client/modules/punch/presentation/punch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const status = PunchStatus(
    isClockedIn: true,
    activeJob: 'Placeholder',
    since: '1h',
    pendingSync: 0,
    gpsAccuracy: 10,
  );

  testWidgets('shows reminder and disables buttons when no job is selected', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          jobSelectionContextProvider.overrideWithValue(
            const JobSelectionContext.none(),
          ),
          punchStatusProvider.overrideWithValue(status),
        ],
        child: const MaterialApp(home: PunchScreen()),
      ),
    );

    expect(
      find.text('Select a job/service before submitting punches.'),
      findsOneWidget,
    );

    final button =
        tester.widget(find.byKey(const ValueKey('punch-action-punch-primary')))
            as ElevatedButton;
    expect(button.onPressed, isNull);
  });

  testWidgets('shows crew context when job is selected', (
    WidgetTester tester,
  ) async {
    const jobContext = JobSelectionContext(
      hasSelection: true,
      jobLabel: 'JOB-1',
      serviceLabel: 'Service',
      crewMembers: [CrewMemberSummary(name: 'Alex', role: 'Foreman')],
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          jobSelectionContextProvider.overrideWithValue(jobContext),
          punchStatusProvider.overrideWithValue(status),
        ],
        child: const MaterialApp(home: PunchScreen()),
      ),
    );

    expect(find.textContaining('Alex'), findsOneWidget);
    final button =
        tester.widget(find.byKey(const ValueKey('punch-action-punch-primary')))
            as ElevatedButton;
    expect(button.onPressed, isNotNull);
  });
}

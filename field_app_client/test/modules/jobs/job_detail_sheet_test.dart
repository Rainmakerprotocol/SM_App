import 'package:field_app_client/modules/jobs/application/job_list_controller.dart'
    show JobListEntry;
import 'package:field_app_client/modules/jobs/presentation/job_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('JobDetailSheet renders metadata and crew chips', (tester) async {
    final job = JobListEntry(
      jobId: 'JOB-42',
      serviceId: 'SRV-10',
      title: 'Storm Cleanup',
      address: '123 Main St, Springfield',
      scheduledDate: DateTime(2025, 11, 21, 8, 30),
      crewNames: const ['Alex', 'Brynn'],
      lastUpdated: DateTime(2025, 11, 21, 7, 15),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(body: JobDetailSheet(job: job)),
      ),
    );

    expect(find.text('Storm Cleanup'), findsOneWidget);
    expect(find.textContaining('Job JOB-42'), findsOneWidget);
    expect(find.text('Alex'), findsOneWidget);
    expect(find.text('Brynn'), findsOneWidget);
    expect(find.text('Copy Job ID'), findsOneWidget);
  });
}

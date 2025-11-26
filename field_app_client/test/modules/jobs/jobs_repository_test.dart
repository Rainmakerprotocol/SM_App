import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:field_app_client/api/job_service.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';
import 'package:field_app_client/modules/jobs/data/jobs_repository.dart';
import 'package:field_app_client/offline/database/app_database.dart';
import 'package:field_app_client/offline/offline_providers.dart';

class _MockJobService extends Mock implements JobService {}

void main() {
  late AppDatabase db;
  late JobsDao jobsDao;
  late _MockJobService service;
  late JobsRepository repository;

  final session = AuthSession(
    token: 'token',
    expiresAt: DateTime(2099, 1, 1),
    displayName: 'Test User',
    employeeId: '12',
  );

  setUp(() {
    db = AppDatabase.forTesting(NativeDatabase.memory());
    jobsDao = JobsDao(db);
    service = _MockJobService();
    repository = JobsRepository(
      jobService: service,
      jobsDao: jobsDao,
      clock: () => DateTime.utc(2025, 11, 21, 10),
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('refreshJobs upserts feed metadata and job rows', () async {
    final feed = JobFeed(
      employeeId: '12',
      range: JobFeedRange(
        start: DateTime.utc(2025, 11, 20),
        end: DateTime.utc(2025, 11, 25),
      ),
      jobs: [
        JobSummary(
          jobId: 'job-1',
          title: 'Main Tear-off',
          address: '123 Main',
          scheduledDate: '2025-11-21',
          scheduledTime: '08:00',
          services: const [
            JobServiceItem(
              jobItemId: 'item-1',
              serviceId: 'svc-1',
              serviceName: 'Roofing',
              status: 3,
            ),
          ],
          crew: const [
            JobCrewMember(
              employeeId: 'E-1',
              name: 'Jane Installer',
              role: 'Installer',
              status: 'IN',
            ),
          ],
        ),
      ],
      apiVersion: '2025-11-20',
      nextCursor: 'cursor-1',
    );
    when(
      () => service.fetchJobs(
        session: session,
        employeeId: '12',
        start: any(named: 'start'),
        end: any(named: 'end'),
      ),
    ).thenAnswer((_) async => feed);

    await repository.refreshJobs(session: session, employeeId: '12');

    final jobs = await db.select(db.jobsLocal).get();
    expect(jobs, hasLength(1));
    expect(jobs.first.jobId, 'job-1');
    expect(jobs.first.customerName, 'Main Tear-off');
    expect(jobs.first.crewHash, isNotEmpty);
    expect(jobs.first.crewListJson, contains('E-1'));

    final state = await db.jobFeedState('12');
    expect(state, isNotNull);
    expect(state!.apiVersion, '2025-11-20');
    expect(state.nextCursor, 'cursor-1');
    expect(
      state.lastRefreshed.isAtSameMomentAs(DateTime.utc(2025, 11, 21, 10)),
      isTrue,
    );
  });

  test(
    'refreshJobs still records feed metadata when no jobs returned',
    () async {
      final feed = JobFeed(
        employeeId: '13',
        range: const JobFeedRange(start: null, end: null),
        jobs: const [],
        apiVersion: null,
        nextCursor: null,
      );
      when(
        () => service.fetchJobs(
          session: session,
          employeeId: '13',
          start: any(named: 'start'),
          end: any(named: 'end'),
        ),
      ).thenAnswer((_) async => feed);

      await repository.refreshJobs(session: session, employeeId: '13');

      final jobs = await db.select(db.jobsLocal).get();
      expect(jobs, isEmpty);

      final state = await db.jobFeedState('13');
      expect(state, isNotNull);
      expect(state!.employeeId, '13');
      expect(
        state.lastRefreshed.isAtSameMomentAs(DateTime.utc(2025, 11, 21, 10)),
        isTrue,
      );
    },
  );
}

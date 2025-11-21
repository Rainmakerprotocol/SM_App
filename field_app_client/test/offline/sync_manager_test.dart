import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:field_app_client/modules/auth/application/auth_controller.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';
import 'package:field_app_client/offline/offline_providers.dart';
import 'package:field_app_client/offline/offline_status.dart';
import 'package:field_app_client/offline/sync/punch_sync_transport.dart';
import 'package:field_app_client/offline/sync/queue_alerts.dart';
import 'package:field_app_client/offline/sync/sync_feedback.dart';
import 'package:field_app_client/offline/sync/sync_manager.dart';
import 'package:field_app_client/offline/sync/sync_providers.dart';
import 'package:field_app_client/offline/sync/sync_state.dart';

class _MockQueueDao extends Mock implements SyncQueueDao {}

class _MockPunchSyncTransport extends Mock implements PunchSyncTransport {}

class _MockPunchesDao extends Mock implements PunchesDao {}

void main() {
  final session = AuthSession(
    token: 'token',
    expiresAt: DateTime(2099, 1, 1),
    displayName: 'Crew Member',
  );

  setUpAll(() {
    registerFallbackValue(<int>[]);
    registerFallbackValue(
      AuthSession(
        token: 'fallback',
        expiresAt: DateTime(2099),
        displayName: 'Fallback',
      ),
    );
  });

  ProviderContainer buildContainer({
    required SyncQueueDao queueDao,
    required PunchesDao punchesDao,
    required PunchSyncTransport transport,
    Duration initialBackoff = const Duration(milliseconds: 10),
  }) {
    return ProviderContainer(
      overrides: [
        syncQueueDaoProvider.overrideWithValue(queueDao),
        punchesDaoProvider.overrideWithValue(punchesDao),
        punchSyncTransportProvider.overrideWithValue(transport),
        offlineStatusProvider.overrideWith(
          (ref) => OfflineStatus(
            hasConnectivity: true,
            lastUpdated: DateTime(2025, 1, 1),
          ),
        ),
        authSessionProvider.overrideWithValue(session),
        syncManagerProvider.overrideWith((ref) {
          return SyncManager(
            queueDao: ref.watch(syncQueueDaoProvider),
            punchesDao: ref.watch(punchesDaoProvider),
            ref: ref,
            transport: ref.watch(punchSyncTransportProvider),
            initialBackoff: initialBackoff,
            maxBackoff: initialBackoff * 2,
          );
        }),
      ],
    );
  }

  test('drains queue when server accepts batch', () async {
    final queueDao = _MockQueueDao();
    final punchesDao = _MockPunchesDao();
    final transport = _MockPunchSyncTransport();

    final batches = <List<QueuedPayload>>[
      [
        const QueuedPayload(
          id: 1,
          entityType: 'punch',
          attemptCount: 0,
          payload: {'mobile_uuid': 'abc', 'job_id': '245'},
        ),
      ],
      <QueuedPayload>[],
    ];

    when(
      () => queueDao.fetchPending(
        limit: any(named: 'limit'),
        onCorrupt: any(named: 'onCorrupt'),
      ),
    ).thenAnswer((_) async => batches.removeAt(0));
    when(() => queueDao.deleteEntries(any())).thenAnswer((_) async {});
    when(() => punchesDao.markSynced(any())).thenAnswer((_) async {});
    when(
      () => punchesDao.markError(
        any(),
        errorCode: any(named: 'errorCode'),
        errorMessage: any(named: 'errorMessage'),
        requiresDispute: any(named: 'requiresDispute'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => transport.send(
        session: any(named: 'session'),
        payloads: any(named: 'payloads'),
      ),
    ).thenAnswer(
      (_) async => const PunchSyncResponse(
        processed: ['abc'],
        duplicates: [],
        errors: [],
      ),
    );

    final container = buildContainer(
      queueDao: queueDao,
      punchesDao: punchesDao,
      transport: transport,
    );
    addTearDown(container.dispose);

    final feedbackFuture = container.read(syncFeedbackStreamProvider.future);
    final manager = container.read(syncManagerProvider);
    await manager.trigger(SyncTrigger.explicit);
    final feedback = await feedbackFuture;

    verify(() => queueDao.deleteEntries([1])).called(1);
    verify(() => punchesDao.markSynced('abc')).called(1);
    expect(manager.state, SyncState.idle);
    expect(feedback.type, SyncFeedbackType.success);
    expect(feedback.processed, 1);
    expect(container.read(lastSuccessfulSyncProvider), isNotNull);
    await manager.dispose();
  });

  test('backs off and records attempt on retryable errors', () async {
    final queueDao = _MockQueueDao();
    final punchesDao = _MockPunchesDao();
    final transport = _MockPunchSyncTransport();

    final batches = <List<QueuedPayload>>[
      [
        const QueuedPayload(
          id: 2,
          entityType: 'punch',
          attemptCount: 0,
          payload: {'mobile_uuid': 'retry-me'},
        ),
      ],
      <QueuedPayload>[],
    ];

    when(
      () => queueDao.fetchPending(
        limit: any(named: 'limit'),
        onCorrupt: any(named: 'onCorrupt'),
      ),
    ).thenAnswer((_) async => batches.removeAt(0));
    when(
      () => queueDao.recordAttempt(any(), error: any(named: 'error')),
    ).thenAnswer((_) async {});
    when(() => punchesDao.markSynced(any())).thenAnswer((_) async {});
    when(
      () => punchesDao.markError(
        any(),
        errorCode: any(named: 'errorCode'),
        errorMessage: any(named: 'errorMessage'),
        requiresDispute: any(named: 'requiresDispute'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => transport.send(
        session: any(named: 'session'),
        payloads: any(named: 'payloads'),
      ),
    ).thenAnswer(
      (_) async => const PunchSyncResponse(
        processed: [],
        duplicates: [],
        errors: [
          PunchSyncError(
            uuid: 'retry-me',
            code: 'server_busy',
            message: 'try later',
          ),
        ],
      ),
    );

    final container = buildContainer(
      queueDao: queueDao,
      punchesDao: punchesDao,
      transport: transport,
    );
    addTearDown(container.dispose);

    final manager = container.read(syncManagerProvider);
    await manager.trigger(SyncTrigger.explicit);

    verify(() => queueDao.recordAttempt(2, error: 'server_busy')).called(1);
    expect(manager.state, SyncState.backingOff);
    verifyNever(() => punchesDao.markSynced(any()));
    verifyNever(
      () => punchesDao.markError(any(), errorCode: any(named: 'errorCode')),
    );
    await manager.dispose();
  });

  test('flags disputes when server rejects punch with invalid job', () async {
    final queueDao = _MockQueueDao();
    final punchesDao = _MockPunchesDao();
    final transport = _MockPunchSyncTransport();

    final batches = <List<QueuedPayload>>[
      [
        const QueuedPayload(
          id: 3,
          entityType: 'punch',
          attemptCount: 0,
          payload: {'mobile_uuid': 'conflict-id'},
        ),
      ],
      <QueuedPayload>[],
    ];

    when(
      () => queueDao.fetchPending(
        limit: any(named: 'limit'),
        onCorrupt: any(named: 'onCorrupt'),
      ),
    ).thenAnswer((_) async => batches.removeAt(0));
    when(() => queueDao.deleteEntries(any())).thenAnswer((_) async {});
    when(() => punchesDao.markSynced(any())).thenAnswer((_) async {});
    when(
      () => punchesDao.markError(
        any(),
        errorCode: any(named: 'errorCode'),
        errorMessage: any(named: 'errorMessage'),
        requiresDispute: any(named: 'requiresDispute'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => transport.send(
        session: any(named: 'session'),
        payloads: any(named: 'payloads'),
      ),
    ).thenAnswer(
      (_) async => const PunchSyncResponse(
        processed: [],
        duplicates: [],
        errors: [
          PunchSyncError(
            uuid: 'conflict-id',
            code: 'invalid_job',
            message: 'Job closed',
          ),
        ],
      ),
    );

    final container = buildContainer(
      queueDao: queueDao,
      punchesDao: punchesDao,
      transport: transport,
    );
    addTearDown(container.dispose);

    final feedbackFuture = container.read(syncFeedbackStreamProvider.future);
    final manager = container.read(syncManagerProvider);
    await manager.trigger(SyncTrigger.explicit);
    final feedback = await feedbackFuture;

    verify(
      () => punchesDao.markError(
        'conflict-id',
        errorCode: 'invalid_job',
        errorMessage: 'Job closed',
        requiresDispute: true,
      ),
    ).called(1);
    expect(feedback.type, SyncFeedbackType.failure);
    expect(feedback.failed, 1);
    await manager.dispose();
  });

  test('deduplicates local queue entries before hitting transport', () async {
    final queueDao = _MockQueueDao();
    final punchesDao = _MockPunchesDao();
    final transport = _MockPunchSyncTransport();

    final batches = <List<QueuedPayload>>[
      [
        const QueuedPayload(
          id: 6,
          entityType: 'punch',
          attemptCount: 0,
          payload: {'mobile_uuid': 'dup-id'},
        ),
        const QueuedPayload(
          id: 7,
          entityType: 'punch',
          attemptCount: 0,
          payload: {'mobile_uuid': 'dup-id'},
        ),
      ],
      <QueuedPayload>[],
    ];

    when(
      () => queueDao.fetchPending(
        limit: any(named: 'limit'),
        onCorrupt: any(named: 'onCorrupt'),
      ),
    ).thenAnswer((_) async => batches.removeAt(0));
    when(() => queueDao.deleteEntries(any())).thenAnswer((_) async {});
    when(() => punchesDao.markSynced(any())).thenAnswer((_) async {});
    when(
      () => punchesDao.markError(
        any(),
        errorCode: any(named: 'errorCode'),
        errorMessage: any(named: 'errorMessage'),
        requiresDispute: any(named: 'requiresDispute'),
      ),
    ).thenAnswer((_) async {});

    var payloadCount = 0;
    when(
      () => transport.send(
        session: any(named: 'session'),
        payloads: any(named: 'payloads'),
      ),
    ).thenAnswer((invocation) async {
      final payloads =
          invocation.namedArguments[#payloads] as List<PunchPayload>;
      payloadCount = payloads.length;
      return const PunchSyncResponse(
        processed: ['dup-id'],
        duplicates: [],
        errors: [],
      );
    });

    final container = buildContainer(
      queueDao: queueDao,
      punchesDao: punchesDao,
      transport: transport,
    );
    addTearDown(container.dispose);

    final manager = container.read(syncManagerProvider);
    await manager.trigger(SyncTrigger.explicit);

    expect(payloadCount, 1);
    verify(() => queueDao.deleteEntries([7])).called(1);
    verify(() => queueDao.deleteEntries([6])).called(1);
    verify(() => punchesDao.markSynced('dup-id')).called(1);
    await manager.dispose();
  });

  test('records validation error when server rejects payload', () async {
    final queueDao = _MockQueueDao();
    final punchesDao = _MockPunchesDao();
    final transport = _MockPunchSyncTransport();

    final batches = <List<QueuedPayload>>[
      [
        const QueuedPayload(
          id: 4,
          entityType: 'punch',
          attemptCount: 0,
          payload: {'mobile_uuid': 'invalid-timestamp'},
        ),
      ],
      <QueuedPayload>[],
    ];

    when(
      () => queueDao.fetchPending(
        limit: any(named: 'limit'),
        onCorrupt: any(named: 'onCorrupt'),
      ),
    ).thenAnswer((_) async => batches.removeAt(0));
    when(() => queueDao.deleteEntries(any())).thenAnswer((_) async {});
    when(() => punchesDao.markSynced(any())).thenAnswer((_) async {});
    when(
      () => punchesDao.markError(
        any(),
        errorCode: any(named: 'errorCode'),
        errorMessage: any(named: 'errorMessage'),
        requiresDispute: any(named: 'requiresDispute'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => transport.send(
        session: any(named: 'session'),
        payloads: any(named: 'payloads'),
      ),
    ).thenAnswer(
      (_) async => const PunchSyncResponse(
        processed: [],
        duplicates: [],
        errors: [
          PunchSyncError(
            uuid: 'invalid-timestamp',
            code: 'validation_error',
            message: 'Timestamp required',
          ),
        ],
      ),
    );

    final container = buildContainer(
      queueDao: queueDao,
      punchesDao: punchesDao,
      transport: transport,
    );
    addTearDown(container.dispose);

    final manager = container.read(syncManagerProvider);
    await manager.trigger(SyncTrigger.explicit);

    verify(
      () => punchesDao.markError(
        'invalid-timestamp',
        errorCode: 'validation_error',
        errorMessage: 'Timestamp required',
        requiresDispute: false,
      ),
    ).called(1);
    await manager.dispose();
  });

  test(
    'emits partial feedback when batch mixes success and retry errors',
    () async {
      final queueDao = _MockQueueDao();
      final punchesDao = _MockPunchesDao();
      final transport = _MockPunchSyncTransport();

      final batches = <List<QueuedPayload>>[
        [
          const QueuedPayload(
            id: 5,
            entityType: 'punch',
            attemptCount: 0,
            payload: {'mobile_uuid': 'ok-id'},
          ),
          const QueuedPayload(
            id: 6,
            entityType: 'punch',
            attemptCount: 0,
            payload: {'mobile_uuid': 'retry-id'},
          ),
        ],
        <QueuedPayload>[],
      ];

      when(
        () => queueDao.fetchPending(
          limit: any(named: 'limit'),
          onCorrupt: any(named: 'onCorrupt'),
        ),
      ).thenAnswer((_) async => batches.removeAt(0));
      when(() => queueDao.deleteEntries(any())).thenAnswer((_) async {});
      when(
        () => queueDao.recordAttempt(any(), error: any(named: 'error')),
      ).thenAnswer((_) async {});
      when(() => punchesDao.markSynced(any())).thenAnswer((_) async {});
      when(
        () => punchesDao.markError(
          any(),
          errorCode: any(named: 'errorCode'),
          errorMessage: any(named: 'errorMessage'),
          requiresDispute: any(named: 'requiresDispute'),
        ),
      ).thenAnswer((_) async {});
      when(
        () => transport.send(
          session: any(named: 'session'),
          payloads: any(named: 'payloads'),
        ),
      ).thenAnswer(
        (_) async => const PunchSyncResponse(
          processed: ['ok-id'],
          duplicates: [],
          errors: [
            PunchSyncError(
              uuid: 'retry-id',
              code: 'server_busy',
              message: 'try later',
            ),
          ],
        ),
      );

      final container = buildContainer(
        queueDao: queueDao,
        punchesDao: punchesDao,
        transport: transport,
      );
      addTearDown(container.dispose);

      final feedbackFuture = container.read(syncFeedbackStreamProvider.future);
      final manager = container.read(syncManagerProvider);
      await manager.trigger(SyncTrigger.explicit);
      final feedback = await feedbackFuture;

      expect(feedback.type, SyncFeedbackType.partialFailure);
      expect(feedback.processed, 1);
      expect(feedback.failed, 1);
      await manager.dispose();
    },
  );

  test('emits queue alert when queue corruption detected', () async {
    final queueDao = _MockQueueDao();
    final punchesDao = _MockPunchesDao();
    final transport = _MockPunchSyncTransport();

    when(
      () => queueDao.fetchPending(
        limit: any(named: 'limit'),
        onCorrupt: any(named: 'onCorrupt'),
      ),
    ).thenAnswer((invocation) async {
      final onCorrupt =
          invocation.namedArguments[#onCorrupt] as void Function()?;
      onCorrupt?.call();
      return <QueuedPayload>[];
    });

    final container = buildContainer(
      queueDao: queueDao,
      punchesDao: punchesDao,
      transport: transport,
    );
    addTearDown(container.dispose);

    final alertFuture = container.read(queueAlertStreamProvider.future);

    final manager = container.read(syncManagerProvider);
    await manager.trigger(SyncTrigger.explicit);
    final alert = await alertFuture;

    expect(alert.message, contains('queued punch'));
    await manager.dispose();
  });
}

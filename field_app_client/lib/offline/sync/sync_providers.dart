import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../offline_providers.dart';
import 'punch_sync_transport.dart';
import 'sync_manager.dart';

final syncManagerProvider = Provider<SyncManager>((ref) {
  final manager = SyncManager(
    queueDao: ref.watch(syncQueueDaoProvider),
    punchesDao: ref.watch(punchesDaoProvider),
    ref: ref,
    transport: ref.watch(punchSyncTransportProvider),
  );

  ref.onDispose(manager.dispose);
  return manager;
});

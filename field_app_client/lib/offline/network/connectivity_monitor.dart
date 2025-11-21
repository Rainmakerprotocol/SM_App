import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../offline_status.dart';
import '../sync/sync_manager.dart';
import '../sync/sync_providers.dart';

final connectivityMonitorProvider = Provider<ConnectivityMonitor>((ref) {
  final monitor = ConnectivityMonitor(ref);
  monitor.start();
  ref.onDispose(monitor.dispose);
  return monitor;
});

class ConnectivityMonitor {
  ConnectivityMonitor(this._ref);

  final Ref _ref;
  StreamSubscription<List<ConnectivityResult>>? _subscription;
  bool? _lastOnline;

  void start() {
    if (_subscription != null) {
      return;
    }
    _subscription = Connectivity().onConnectivityChanged.listen(_handle);
    Connectivity().checkConnectivity().then(_handle);
  }

  void _handle(List<ConnectivityResult> results) {
    final result = results.isNotEmpty ? results.last : ConnectivityResult.none;
    final hasConnectivity = result != ConnectivityResult.none;
    final notifier = _ref.read(offlineStatusProvider.notifier);
    notifier.state = OfflineStatus(
      hasConnectivity: hasConnectivity,
      lastUpdated: DateTime.now(),
    );

    if (hasConnectivity && _lastOnline == false) {
      _ref.read(syncManagerProvider).trigger(SyncTrigger.networkReconnect);
    }
    _lastOnline = hasConnectivity;
  }

  void dispose() {
    _subscription?.cancel();
    _subscription = null;
  }
}

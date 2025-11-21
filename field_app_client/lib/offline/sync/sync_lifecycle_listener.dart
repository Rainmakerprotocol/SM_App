import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../modules/auth/application/auth_controller.dart';
import 'sync_manager.dart';
import 'sync_providers.dart';

class SyncLifecycleListener extends ConsumerStatefulWidget {
  const SyncLifecycleListener({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<SyncLifecycleListener> createState() =>
      _SyncLifecycleListenerState();
}

class _SyncLifecycleListenerState extends ConsumerState<SyncLifecycleListener>
    with WidgetsBindingObserver {
  Timer? _periodicTimer;
  ProviderSubscription<AuthState>? _authSubscription;

  static const _interval = Duration(minutes: 5);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _authSubscription = ref.listenManual<AuthState>(
      authControllerProvider,
      _handleAuthStateChanged,
    );
    _periodicTimer = Timer.periodic(
      _interval,
      (_) => _trigger(SyncTrigger.periodic),
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _trigger(SyncTrigger.foreground);
    });
  }

  void _handleAuthStateChanged(AuthState? previous, AuthState next) {
    final wasAuthenticated = previous?.isAuthenticated ?? false;
    if (!wasAuthenticated && next.isAuthenticated) {
      _trigger(SyncTrigger.explicit);
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _trigger(SyncTrigger.foreground);
    }
  }

  Future<void> _trigger(SyncTrigger trigger) {
    final manager = ref.read(syncManagerProvider);
    return manager.trigger(trigger);
  }

  @override
  void dispose() {
    _periodicTimer?.cancel();
    _authSubscription?.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

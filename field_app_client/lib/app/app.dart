import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/theme/app_theme.dart';
import '../modules/auth/presentation/auth_gate.dart';
import '../offline/sync/sync_lifecycle_listener.dart';

class FieldApp extends ConsumerWidget {
  const FieldApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SyncLifecycleListener(
      child: MaterialApp(
        title: 'Storm Master Field',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        home: const AuthGate(),
      ),
    );
  }
}

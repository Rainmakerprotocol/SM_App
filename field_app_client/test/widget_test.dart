import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_app_client/app/app.dart';
import 'package:field_app_client/modules/auth/application/auth_controller.dart';
import 'package:field_app_client/modules/auth/data/token_storage.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';

class _FakeTokenStorage implements TokenStorage {
  AuthSession? _session;

  @override
  Future<void> saveSession(AuthSession session) async {
    _session = session;
  }

  @override
  Future<AuthSession?> readSession() async => _session;

  @override
  Future<void> clearSession() async {
    _session = null;
  }

  @override
  Future<void> clearAll() async {
    _session = null;
  }

  @override
  Future<String> deviceId() async => 'test-device';
}

void main() {
  testWidgets('Login gate renders for unauthenticated users', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          tokenStorageProvider.overrideWithValue(_FakeTokenStorage()),
        ],
        child: const FieldApp(),
      ),
    );
    await tester.pump(const Duration(milliseconds: 200));

    expect(find.text('Storm Master Field App'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });
}

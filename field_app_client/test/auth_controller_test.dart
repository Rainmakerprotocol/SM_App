import 'package:flutter_test/flutter_test.dart';

import 'package:field_app_client/modules/auth/application/auth_controller.dart';
import 'package:field_app_client/modules/auth/data/auth_metadata_collector.dart';
import 'package:field_app_client/modules/auth/data/auth_service.dart';
import 'package:field_app_client/modules/auth/data/token_storage.dart';
import 'package:field_app_client/modules/auth/domain/auth_models.dart';

class TestAuthService implements AuthService {
  TestAuthService({this.result, this.exception});

  AuthResult? result;
  AuthException? exception;
  bool logoutCalled = false;

  @override
  Future<AuthResult> login({
    required AuthCredentials credentials,
    required AuthMetadata metadata,
  }) async {
    if (exception != null) throw exception!;
    return result ??
        AuthResult(
          session: AuthSession(
            token: 'token',
            displayName: credentials.identity,
            expiresAt: DateTime.now().add(const Duration(days: 30)),
            employeeId: '12',
          ),
        );
  }

  @override
  Future<void> logout() async {
    logoutCalled = true;
  }
}

class InMemoryTokenStorage implements TokenStorage {
  AuthSession? _session;
  String? _deviceId;

  @override
  Future<void> clearAll() async {
    _session = null;
    _deviceId = null;
  }

  @override
  Future<void> clearSession() async {
    _session = null;
  }

  @override
  Future<String> deviceId() async {
    _deviceId ??= 'device-123';
    return _deviceId!;
  }

  @override
  Future<AuthSession?> readSession() async {
    return _session;
  }

  @override
  Future<void> saveSession(AuthSession session) async {
    _session = session;
  }
}

class StubMetadataCollector implements AuthMetadataProvider {
  const StubMetadataCollector();

  @override
  Future<AuthMetadata> collect() async {
    return const AuthMetadata(
      platform: 'test',
      model: 'tester',
      appVersion: '1.0.0',
      deviceId: 'device-123',
    );
  }
}

void main() {
  group('AuthController', () {
    late TestAuthService authService;
    late InMemoryTokenStorage storage;
    const metadataCollector = StubMetadataCollector();

    setUp(() {
      authService = TestAuthService();
      storage = InMemoryTokenStorage();
    });

    test('restores cached session on init', () async {
      final session = AuthSession(
        token: 'saved-token',
        displayName: 'Jamie',
        expiresAt: DateTime.now().add(const Duration(days: 1)),
        employeeId: '12',
      );
      await storage.saveSession(session);

      final controller = AuthController(
        authService: authService,
        tokenStorage: storage,
        metadataCollector: metadataCollector,
      );

      await pumpEventQueue();

      expect(controller.state.isInitialized, isTrue);
      expect(controller.state.isAuthenticated, isTrue);
      expect(controller.state.displayName, equals('Jamie'));
    });

    test('handleUnauthorized clears session and authentication state', () async {
      final session = AuthSession(
        token: 'saved-token',
        displayName: 'Jamie',
        expiresAt: DateTime.now().add(const Duration(days: 1)),
        employeeId: '12',
      );
      await storage.saveSession(session);

      final controller = AuthController(
        authService: authService,
        tokenStorage: storage,
        metadataCollector: metadataCollector,
      );
      await pumpEventQueue();

      await controller.handleUnauthorized();

      expect(await storage.readSession(), isNull);
      expect(controller.state.isAuthenticated, isFalse);
    });

    test('signIn persists session and updates state', () async {
      final controller = AuthController(
        authService: authService,
        tokenStorage: storage,
        metadataCollector: metadataCollector,
      );
      await pumpEventQueue();

      await controller.signIn(identity: 'crew', password: 'secret');

      expect(controller.state.isAuthenticated, isTrue);
      expect(controller.state.displayName, 'crew');
      expect(await storage.readSession(), isNotNull);
    });
  });
}

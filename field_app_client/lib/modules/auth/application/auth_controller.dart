import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../data/auth_metadata_collector.dart';
import '../data/auth_service.dart';
import '../data/token_storage.dart';
import '../domain/auth_models.dart';

final _secureStorageProvider = Provider<FlutterSecureStorage>((ref) {
  return const FlutterSecureStorage();
});

final tokenStorageProvider = Provider<TokenStorage>((ref) {
  return TokenStorage.secure(ref.watch(_secureStorageProvider));
});

final deviceInfoProvider = Provider<DeviceInfoPlugin>((ref) {
  return DeviceInfoPlugin();
});

final authMetadataCollectorProvider = Provider<AuthMetadataProvider>((ref) {
  return AuthMetadataCollector(
    deviceInfo: ref.watch(deviceInfoProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
  );
});

final httpClientProvider = Provider<http.Client>((ref) {
  final client = http.Client();
  ref.onDispose(client.close);
  return client;
});

const _useMockAuth = bool.fromEnvironment('USE_MOCK_AUTH', defaultValue: true);
const _apiBaseUrl = String.fromEnvironment(
  'SM_API_BASE_URL',
  defaultValue: 'https://stormmaster.local',
);

final authServiceProvider = Provider<AuthService>((ref) {
  if (_useMockAuth) {
    return MockAuthService();
  }
  return RestAuthService(
    httpClient: ref.watch(httpClientProvider),
    baseUrl: _apiBaseUrl,
  );
});

final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  return AuthController(
    authService: ref.watch(authServiceProvider),
    tokenStorage: ref.watch(tokenStorageProvider),
    metadataCollector: ref.watch(authMetadataCollectorProvider),
  );
});

class AuthState {
  const AuthState({
    required this.isAuthenticated,
    required this.isInitialized,
    this.isLoading = false,
    this.displayName,
    this.errorMessage,
    this.session,
  });

  factory AuthState.initial() =>
      const AuthState(isAuthenticated: false, isInitialized: false);

  final bool isAuthenticated;
  final bool isInitialized;
  final bool isLoading;
  final String? displayName;
  final String? errorMessage;
  final AuthSession? session;

  AuthState copyWith({
    bool? isAuthenticated,
    bool? isInitialized,
    bool? isLoading,
    String? displayName,
    String? errorMessage,
    bool clearErrorMessage = false,
    bool clearDisplayName = false,
    AuthSession? session,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      isInitialized: isInitialized ?? this.isInitialized,
      isLoading: isLoading ?? this.isLoading,
      displayName:
          clearDisplayName ? null : (displayName ?? this.displayName),
      errorMessage:
          clearErrorMessage ? null : (errorMessage ?? this.errorMessage),
      session: session ?? this.session,
    );
  }
}

class AuthController extends StateNotifier<AuthState> {
  AuthController({
    required AuthService authService,
    required TokenStorage tokenStorage,
    required AuthMetadataProvider metadataCollector,
  })  : _authService = authService,
        _tokenStorage = tokenStorage,
        _metadataCollector = metadataCollector,
        super(AuthState.initial()) {
    _restoreSession();
  }

  final AuthService _authService;
  final TokenStorage _tokenStorage;
  final AuthMetadataProvider _metadataCollector;

  Future<void> _restoreSession() async {
    final session = await _tokenStorage.readSession();
    if (session != null && session.expiresAt.isAfter(DateTime.now())) {
      state = state.copyWith(
        isAuthenticated: true,
        isInitialized: true,
        displayName: session.displayName,
        session: session,
      );
      return;
    }

    await _tokenStorage.clearSession();
    state = state.copyWith(
      isInitialized: true,
      isAuthenticated: false,
      session: null,
      clearErrorMessage: true,
      clearDisplayName: true,
    );
  }

  Future<void> signIn({
    required String identity,
    required String password,
  }) async {
    final trimmed = identity.trim();
    if (trimmed.isEmpty || password.isEmpty) {
      state = state.copyWith(errorMessage: 'Credentials required.');
      return;
    }

    state = state.copyWith(isLoading: true, clearErrorMessage: true);
    try {
      final metadata = await _metadataCollector.collect();
      final result = await _authService.login(
        credentials: AuthCredentials(identity: trimmed, password: password),
        metadata: metadata,
      );
      await _tokenStorage.saveSession(result.session);
      state = state.copyWith(
        isAuthenticated: true,
        isInitialized: true,
        isLoading: false,
        displayName: result.session.displayName,
        session: result.session,
      );
    } on AuthException catch (error) {
      await _tokenStorage.clearSession();
      state = state.copyWith(
        isAuthenticated: false,
        isInitialized: true,
        isLoading: false,
        errorMessage: error.message,
        session: null,
        clearDisplayName: true,
      );
    } catch (error) {
      state = state.copyWith(
        isAuthenticated: false,
        isInitialized: true,
        isLoading: false,
        errorMessage: 'Unable to complete login',
        session: null,
        clearDisplayName: true,
      );
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(isLoading: true);
    await _authService.logout();
    await _tokenStorage.clearAll();
    state = AuthState.initial().copyWith(
      isInitialized: true,
      clearErrorMessage: true,
      clearDisplayName: true,
    );
  }

  Future<void> handleUnauthorized() async {
    await _tokenStorage.clearSession();
    state = state.copyWith(
      isAuthenticated: false,
      session: null,
      clearErrorMessage: true,
      clearDisplayName: true,
    );
  }
}

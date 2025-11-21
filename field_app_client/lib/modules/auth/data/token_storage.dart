import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:uuid/uuid.dart';

import '../domain/auth_models.dart';

abstract class TokenStorage {
  Future<void> saveSession(AuthSession session);
  Future<AuthSession?> readSession();
  Future<void> clearSession();
  Future<void> clearAll();
  Future<String> deviceId();

  factory TokenStorage.secure(FlutterSecureStorage secureStorage) =
      _SecureTokenStorage;
}

class _SecureTokenStorage implements TokenStorage {
  _SecureTokenStorage(this._secureStorage);

  final FlutterSecureStorage _secureStorage;
  static const _sessionKey = 'auth_session';
  static const _deviceKey = 'device_id';
  static const _uuid = Uuid();

  @override
  Future<void> saveSession(AuthSession session) {
    return _secureStorage.write(key: _sessionKey, value: session.encode());
  }

  @override
  Future<AuthSession?> readSession() async {
    final value = await _secureStorage.read(key: _sessionKey);
    if (value == null) return null;
    return AuthSession.decode(value);
  }

  @override
  Future<void> clearSession() {
    return _secureStorage.delete(key: _sessionKey);
  }

  @override
  Future<void> clearAll() {
    return _secureStorage.deleteAll();
  }

  @override
  Future<String> deviceId() async {
    final cached = await _secureStorage.read(key: _deviceKey);
    if (cached != null) {
      return cached;
    }
    final generated = _uuid.v4();
    await _secureStorage.write(key: _deviceKey, value: generated);
    return generated;
  }
}

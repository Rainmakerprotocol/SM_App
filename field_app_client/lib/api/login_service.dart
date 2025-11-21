import 'dart:convert' as convert;

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../modules/auth/domain/auth_models.dart';

abstract class AuthService {
  Future<AuthResult> login({
    required AuthCredentials credentials,
    required AuthMetadata metadata,
  });

  Future<void> logout();
}

class RestAuthService implements AuthService {
  RestAuthService({required this.httpClient, required this.baseUrl});

  final http.Client httpClient;
  final String baseUrl;

  @override
  Future<AuthResult> login({
    required AuthCredentials credentials,
    required AuthMetadata metadata,
  }) async {
    final payload = {
      'email': credentials.identity,
      'password': credentials.password,
      'device': metadata.toJson(),
    };

    final response = await httpClient.post(
      Uri.parse('$baseUrl/api/login'),
      headers: {'Content-Type': 'application/json'},
      body: convert.jsonEncode(payload),
    );

    if (response.statusCode == 401) {
      throw AuthException('Invalid credentials', code: 'unauthorized');
    }

    if (response.statusCode >= 400) {
      throw AuthException('Unable to sign in (code ${response.statusCode})');
    }

    final body = convert.jsonDecode(response.body) as Map<String, dynamic>;
    final token = body['token'] as String?;
    final displayName = body['user']?['name'] as String? ?? 'Crew Member';

    if (token == null) {
      throw AuthException('Malformed login response');
    }

    final expiresAt = DateTime.now().add(const Duration(days: 30));
    return AuthResult(
      session: AuthSession(
        token: token,
        displayName: displayName,
        expiresAt: expiresAt,
      ),
    );
  }

  @override
  Future<void> logout() async {
    await SynchronousFuture(null);
  }
}

class MockAuthService implements AuthService {
  @override
  Future<AuthResult> login({
    required AuthCredentials credentials,
    required AuthMetadata metadata,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (credentials.password == 'invalid') {
      throw AuthException('Invalid credentials', code: 'unauthorized');
    }

    final session = AuthSession(
      token: 'mock-token-${credentials.identity}',
      displayName: credentials.identity,
      expiresAt: DateTime.now().add(const Duration(days: 30)),
    );
    return AuthResult(session: session);
  }

  @override
  Future<void> logout() async {}
}

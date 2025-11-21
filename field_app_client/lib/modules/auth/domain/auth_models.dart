import 'dart:convert';

class AuthCredentials {
  const AuthCredentials({required this.identity, required this.password});
  final String identity;
  final String password;
}

class AuthSession {
  const AuthSession({
    required this.token,
    required this.expiresAt,
    required this.displayName,
  });

  final String token;
  final DateTime expiresAt;
  final String displayName;

  Map<String, dynamic> toJson() => {
        'token': token,
        'expiresAt': expiresAt.toIso8601String(),
        'displayName': displayName,
      };

  factory AuthSession.fromJson(Map<String, dynamic> json) {
    return AuthSession(
      token: json['token'] as String,
      displayName: json['displayName'] as String? ?? 'Crew Member',
      expiresAt: DateTime.parse(json['expiresAt'] as String),
    );
  }

  String encode() => jsonEncode(toJson());
  factory AuthSession.decode(String raw) => AuthSession.fromJson(jsonDecode(raw));
}

class AuthMetadata {
  const AuthMetadata({
    required this.platform,
    required this.model,
    required this.appVersion,
    required this.deviceId,
  });

  final String platform;
  final String model;
  final String appVersion;
  final String deviceId;

  Map<String, dynamic> toJson() => {
        'platform': platform,
        'model': model,
        'app_version': appVersion,
        'device_id': deviceId,
      };
}

class AuthResult {
  const AuthResult({required this.session});
  final AuthSession session;
}

class AuthException implements Exception {
  AuthException(this.message, {this.code});
  final String message;
  final String? code;
}

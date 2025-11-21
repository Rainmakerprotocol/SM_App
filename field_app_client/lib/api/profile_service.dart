import 'dart:convert' as convert;

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

import '../config/app_config.dart';
import '../core/network/http_client_provider.dart';
import '../modules/auth/domain/auth_models.dart';

class ProfileDetails {
  const ProfileDetails({
    required this.employeeId,
    required this.displayName,
    this.email,
    this.phone,
    this.crew,
    this.role,
    this.deviceId,
    this.osVersion,
    this.lastSync,
  });

  final String employeeId;
  final String displayName;
  final String? email;
  final String? phone;
  final String? crew;
  final String? role;
  final String? deviceId;
  final String? osVersion;
  final DateTime? lastSync;

  factory ProfileDetails.fromJson(Map<String, dynamic> json) {
    return ProfileDetails(
      employeeId: json['employee_id']?.toString() ?? '',
      displayName: json['display_name']?.toString() ?? 'Crew Member',
      email: json['email']?.toString(),
      phone: json['phone']?.toString(),
      crew: json['crew']?.toString(),
      role: json['role']?.toString(),
      deviceId: json['device_id']?.toString(),
      osVersion: json['os_version']?.toString(),
      lastSync: json['last_sync'] == null
          ? null
          : DateTime.tryParse(json['last_sync'].toString()),
    );
  }
}

class ProfileUpdateRequest {
  const ProfileUpdateRequest({
    required this.employeeId,
    this.phone,
    this.address,
    this.companyPhone,
  });

  final String employeeId;
  final String? phone;
  final String? address;
  final String? companyPhone;

  Map<String, dynamic> toJson() {
    return {
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (companyPhone != null) 'company_phone': companyPhone,
    };
  }
}

abstract class ProfileService {
  Future<ProfileDetails> fetchProfile({
    required AuthSession session,
    required String employeeId,
  });

  Future<ProfileDetails> updateProfile({
    required AuthSession session,
    required ProfileUpdateRequest request,
  });
}

class RestProfileService implements ProfileService {
  RestProfileService({required this.httpClient, required this.baseUrl});

  final http.Client httpClient;
  final String baseUrl;

  Map<String, String> _headers(AuthSession session) => {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer ${session.token}',
  };

  @override
  Future<ProfileDetails> fetchProfile({
    required AuthSession session,
    required String employeeId,
  }) async {
    final response = await httpClient.get(
      Uri.parse('$baseUrl/api/mobile/profile/$employeeId'),
      headers: _headers(session),
    );

    if (response.statusCode == 401) {
      throw AuthException('Session expired', code: 'unauthorized');
    }

    if (response.statusCode >= 500) {
      throw AuthException('Profile unavailable', code: 'server');
    }

    if (response.statusCode >= 400) {
      throw AuthException('Profile not found', code: 'not_found');
    }

    return ProfileDetails.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>,
    );
  }

  @override
  Future<ProfileDetails> updateProfile({
    required AuthSession session,
    required ProfileUpdateRequest request,
  }) async {
    final response = await httpClient.put(
      Uri.parse('$baseUrl/api/mobile/profile/${request.employeeId}'),
      headers: _headers(session),
      body: convert.jsonEncode(request.toJson()),
    );

    if (response.statusCode == 401) {
      throw AuthException('Session expired', code: 'unauthorized');
    }

    if (response.statusCode >= 500) {
      throw AuthException('Unable to update profile', code: 'server');
    }

    if (response.statusCode >= 400) {
      throw AuthException('Validation failed', code: 'validation_error');
    }

    return ProfileDetails.fromJson(
      convert.jsonDecode(response.body) as Map<String, dynamic>,
    );
  }
}

class MockProfileService implements ProfileService {
  @override
  Future<ProfileDetails> fetchProfile({
    required AuthSession session,
    required String employeeId,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return ProfileDetails(
      employeeId: employeeId,
      displayName: 'Mock Crew Member',
      email: 'mock@example.com',
      phone: '+1 555-0100',
      crew: 'Mock Crew',
      role: 'Installer',
      deviceId: 'mock-device',
      osVersion: 'Android 15',
      lastSync: DateTime.now(),
    );
  }

  @override
  Future<ProfileDetails> updateProfile({
    required AuthSession session,
    required ProfileUpdateRequest request,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return ProfileDetails(
      employeeId: request.employeeId,
      displayName: 'Mock Crew Member',
      phone: request.phone ?? '+1 555-0100',
      crew: 'Mock Crew',
      role: 'Installer',
      email: 'mock@example.com',
      deviceId: 'mock-device',
      osVersion: 'Android 15',
      lastSync: DateTime.now(),
    );
  }
}

final profileServiceProvider = Provider<ProfileService>((ref) {
  if (AppConfig.useMockProfileApi) {
    return MockProfileService();
  }
  return RestProfileService(
    httpClient: ref.watch(httpClientProvider),
    baseUrl: AppConfig.apiBaseUrl,
  );
});

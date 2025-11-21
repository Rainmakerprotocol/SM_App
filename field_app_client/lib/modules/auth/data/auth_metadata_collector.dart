import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../domain/auth_models.dart';
import 'token_storage.dart';

abstract class AuthMetadataProvider {
  Future<AuthMetadata> collect();
}

class AuthMetadataCollector implements AuthMetadataProvider {
  AuthMetadataCollector({
    required DeviceInfoPlugin deviceInfo,
    required this.tokenStorage,
  }) : _deviceInfo = deviceInfo;

  final DeviceInfoPlugin _deviceInfo;
  final TokenStorage tokenStorage;

  @override
  Future<AuthMetadata> collect() async {
    final packageInfo = await PackageInfo.fromPlatform();
    final deviceId = await tokenStorage.deviceId();

    if (Platform.isAndroid) {
      final android = await _deviceInfo.androidInfo;
      return AuthMetadata(
        platform: 'android',
        model: _safeModel(android.model),
        appVersion: packageInfo.version,
        deviceId: deviceId,
      );
    }

    if (Platform.isIOS) {
      final ios = await _deviceInfo.iosInfo;
      return AuthMetadata(
        platform: 'ios',
        model: _safeModel(ios.utsname.machine),
        appVersion: packageInfo.version,
        deviceId: deviceId,
      );
    }

    final base = await _deviceInfo.deviceInfo;
    return AuthMetadata(
      platform: Platform.operatingSystem,
      model: _safeModel(base.data['model']?.toString()),
      appVersion: packageInfo.version,
      deviceId: deviceId,
    );
  }
}

String _safeModel(String? value) {
  if (value == null || value.isEmpty) {
    return 'unknown';
  }
  return value;
}

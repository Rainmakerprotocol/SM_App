import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../services/gps_service.dart';

/// GPS service singleton provider.
final gpsServiceProvider = Provider<GpsService>((ref) {
  return GpsService();
});

/// Current GPS coordinate provider (one-time fetch).
///
/// Returns null if permission denied, location disabled, or timeout.
final currentGpsProvider = FutureProvider<GpsCoordinate?>((ref) async {
  final service = ref.read(gpsServiceProvider);
  return await service.getCurrentLocation();
});

/// GPS coordinate stream provider for continuous updates.
///
/// Useful for real-time GPS quality indicators in UI.
/// Updates every 10 meters or when accuracy changes significantly.
final gpsStreamProvider = StreamProvider<GpsCoordinate>((ref) {
  final service = ref.read(gpsServiceProvider);
  return service.watchLocation();
});

/// GPS permission status provider.
final gpsPermissionProvider = FutureProvider<bool>((ref) async {
  final service = ref.read(gpsServiceProvider);
  return await service.requestPermission();
});

import 'dart:async';

import 'package:geolocator/geolocator.dart';

/// GPS service for acquiring device location with timeout and fallback logic.
///
/// Per DL-006: Requests high-accuracy fix for up to 10 seconds, falls back
/// to last cached coordinate if available, otherwise marks gps_unavailable=true.
class GpsService {
  GpsService({
    Duration? timeout,
    double? lowAccuracyThreshold,
  })  : _timeout = timeout ?? const Duration(seconds: 10),
        _lowAccuracyThreshold = lowAccuracyThreshold ?? 80.0;

  final Duration _timeout;
  final double _lowAccuracyThreshold;

  /// Request foreground location permission.
  ///
  /// Returns true if permission is granted (either already or after prompt).
  /// Returns false if denied or permanently denied.
  Future<bool> requestPermission() async {
    // Check current permission status
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      // Request permission
      permission = await Geolocator.requestPermission();
    }

    // Return true only if we have permission
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  /// Check if location services are enabled on the device.
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  /// Get current location with high accuracy and timeout.
  ///
  /// Returns null if:
  /// - Permission denied
  /// - Location services disabled
  /// - Timeout exceeded and no cached position available
  ///
  /// The [isFromCache] flag indicates if the coordinate came from fallback.
  Future<GpsCoordinate?> getCurrentLocation({
    Duration? timeout,
  }) async {
    final effectiveTimeout = timeout ?? _timeout;

    // Check permission first
    final hasPermission = await requestPermission();
    if (!hasPermission) {
      return null;
    }

    // Check if location services are enabled
    final serviceEnabled = await isLocationServiceEnabled();
    if (!serviceEnabled) {
      return null;
    }

    try {
      // Attempt high-accuracy fix with timeout
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
        timeLimit: effectiveTimeout,
      );

      return GpsCoordinate(
        lat: position.latitude,
        lng: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp ?? DateTime.now(),
        isFromCache: false,
      );
    } on TimeoutException {
      // Timeout exceeded, try to get last known position
      return await _getLastKnownPosition();
    } catch (e) {
      // Any other error, try fallback
      return await _getLastKnownPosition();
    }
  }

  /// Get last known (cached) position as fallback.
  Future<GpsCoordinate?> _getLastKnownPosition() async {
    try {
      final position = await Geolocator.getLastKnownPosition();
      if (position == null) {
        return null;
      }

      return GpsCoordinate(
        lat: position.latitude,
        lng: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp ?? DateTime.now(),
        isFromCache: true,
      );
    } catch (e) {
      return null;
    }
  }

  /// Stream continuous location updates.
  ///
  /// Useful for real-time GPS quality indicators in UI.
  /// Remember to cancel the stream subscription when done.
  Stream<GpsCoordinate> watchLocation() {
    const locationSettings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 10, // Update every 10 meters
    );

    return Geolocator.getPositionStream(locationSettings: locationSettings)
        .map(
      (position) => GpsCoordinate(
        lat: position.latitude,
        lng: position.longitude,
        accuracy: position.accuracy,
        timestamp: position.timestamp ?? DateTime.now(),
        isFromCache: false,
      ),
    );
  }

  /// Check if a coordinate has low accuracy (>80m by default).
  bool isLowAccuracy(GpsCoordinate coordinate) {
    return coordinate.accuracy > _lowAccuracyThreshold;
  }

  /// Get permission status without requesting.
  Future<LocationPermission> getPermissionStatus() async {
    return await Geolocator.checkPermission();
  }
}

/// GPS coordinate with metadata.
class GpsCoordinate {
  const GpsCoordinate({
    required this.lat,
    required this.lng,
    required this.accuracy,
    required this.timestamp,
    required this.isFromCache,
  });

  final double lat;
  final double lng;
  final double accuracy; // meters
  final DateTime timestamp;
  final bool isFromCache; // true if from fallback, false if fresh fix

  /// Quality assessment based on accuracy.
  GpsQuality get quality {
    if (accuracy <= 20) return GpsQuality.good;
    if (accuracy <= 80) return GpsQuality.fair;
    return GpsQuality.poor;
  }

  @override
  String toString() {
    return 'GpsCoordinate(lat: $lat, lng: $lng, accuracy: ${accuracy.toStringAsFixed(1)}m, '
        'cached: $isFromCache, quality: ${quality.name})';
  }
}

/// GPS quality levels for UI display.
enum GpsQuality {
  good, // ≤20m
  fair, // ≤80m
  poor, // >80m
}

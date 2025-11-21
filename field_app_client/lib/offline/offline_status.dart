import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfflineStatus {
  const OfflineStatus({
    required this.hasConnectivity,
    required this.lastUpdated,
  });

  final bool hasConnectivity;
  final DateTime lastUpdated;

  OfflineStatus copyWith({bool? hasConnectivity, DateTime? lastUpdated}) {
    return OfflineStatus(
      hasConnectivity: hasConnectivity ?? this.hasConnectivity,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}

final offlineStatusProvider = StateProvider<OfflineStatus>((ref) {
  return OfflineStatus(hasConnectivity: true, lastUpdated: DateTime.now());
});

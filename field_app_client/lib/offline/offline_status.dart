import 'package:flutter_riverpod/flutter_riverpod.dart';

class OfflineStatus {
  const OfflineStatus({required this.hasConnectivity});
  final bool hasConnectivity;
}

final offlineStatusProvider = StateProvider<OfflineStatus>((ref) {
  return const OfflineStatus(hasConnectivity: true);
});

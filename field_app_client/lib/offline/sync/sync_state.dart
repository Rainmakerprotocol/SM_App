import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks the timestamp of the most recent successful or partial punch sync.
final lastSuccessfulSyncProvider = StateProvider<DateTime?>((ref) => null);

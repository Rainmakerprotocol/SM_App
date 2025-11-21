import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Describes how a punch sync batch completed so UI layers can surface
/// contextual banners/snackbars without digging into queue internals.
class SyncFeedback {
  const SyncFeedback._({
    required this.type,
    required this.total,
    required this.processed,
    required this.failed,
  });

  const SyncFeedback.success({required int total, required int processed})
    : this._(
        type: SyncFeedbackType.success,
        total: total,
        processed: processed,
        failed: 0,
      );

  const SyncFeedback.partial({
    required int total,
    required int processed,
    required int failed,
  }) : this._(
         type: SyncFeedbackType.partialFailure,
         total: total,
         processed: processed,
         failed: failed,
       );

  const SyncFeedback.failure({required int total, required int failed})
    : this._(
        type: SyncFeedbackType.failure,
        total: total,
        processed: 0,
        failed: failed,
      );

  final SyncFeedbackType type;
  final int total;
  final int processed;
  final int failed;

  String buildMessage() {
    final pluralProcessed = processed == 1 ? 'punch' : 'punches';
    final pluralFailed = failed == 1 ? 'punch' : 'punches';
    switch (type) {
      case SyncFeedbackType.success:
        return 'Synced $processed $pluralProcessed.';
      case SyncFeedbackType.partialFailure:
        return '$processed $pluralProcessed synced, $failed $pluralFailed still need attention.';
      case SyncFeedbackType.failure:
        return '$failed $pluralFailed could not sync. Please review and retry.';
    }
  }
}

enum SyncFeedbackType { success, partialFailure, failure }

class SyncFeedbackController {
  final _controller = StreamController<SyncFeedback>.broadcast();

  Stream<SyncFeedback> get stream => _controller.stream;

  void emit(SyncFeedback feedback) {
    if (_controller.isClosed) {
      return;
    }
    _controller.add(feedback);
  }

  void dispose() {
    _controller.close();
  }
}

final syncFeedbackControllerProvider = Provider<SyncFeedbackController>((ref) {
  final controller = SyncFeedbackController();
  ref.onDispose(controller.dispose);
  return controller;
});

final syncFeedbackStreamProvider = StreamProvider<SyncFeedback>((ref) {
  return ref.watch(syncFeedbackControllerProvider).stream;
});

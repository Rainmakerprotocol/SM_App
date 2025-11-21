import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class QueueAlert {
  const QueueAlert({required this.message});
  final String message;
}

class QueueAlertController {
  final _controller = StreamController<QueueAlert>.broadcast();

  Stream<QueueAlert> get stream => _controller.stream;

  void emit(String message) {
    if (_controller.isClosed) {
      return;
    }
    _controller.add(QueueAlert(message: message));
  }

  void dispose() {
    _controller.close();
  }
}

final queueAlertControllerProvider = Provider<QueueAlertController>((ref) {
  final controller = QueueAlertController();
  ref.onDispose(controller.dispose);
  return controller;
});

final queueAlertStreamProvider = StreamProvider<QueueAlert>((ref) {
  return ref.watch(queueAlertControllerProvider).stream;
});

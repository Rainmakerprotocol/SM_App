import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final punchActionThrottleProvider =
    StateNotifierProvider<PunchActionThrottleNotifier, Set<String>>(
      (ref) => PunchActionThrottleNotifier(),
    );

class PunchActionThrottleNotifier extends StateNotifier<Set<String>> {
  PunchActionThrottleNotifier({this.cooldown = const Duration(seconds: 2)})
    : super(<String>{});

  final Duration cooldown;

  bool tryTrigger(String actionKey) {
    if (state.contains(actionKey)) {
      return false;
    }
    state = {...state, actionKey};
    _scheduleRelease(actionKey);
    return true;
  }

  bool isCooling(String actionKey) => state.contains(actionKey);

  void _scheduleRelease(String actionKey) {
    unawaited(
      Future.delayed(cooldown, () {
        if (!mounted || !state.contains(actionKey)) {
          return;
        }
        final next = {...state}..remove(actionKey);
        state = next;
      }),
    );
  }
}

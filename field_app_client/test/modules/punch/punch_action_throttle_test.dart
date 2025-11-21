import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/riverpod.dart';

import 'package:field_app_client/modules/punch/presentation/punch_action_throttle.dart';

void main() {
  test('throttle prevents rapid double taps until cooldown expires', () async {
    final container = ProviderContainer(
      overrides: [
        punchActionThrottleProvider.overrideWith(
          (ref) =>
              PunchActionThrottleNotifier(cooldown: Duration(milliseconds: 50)),
        ),
      ],
    );
    addTearDown(container.dispose);

    final notifier = container.read(punchActionThrottleProvider.notifier);

    expect(notifier.tryTrigger('punch-main'), isTrue);
    expect(notifier.tryTrigger('punch-main'), isFalse);

    await Future<void>.delayed(const Duration(milliseconds: 75));

    expect(notifier.tryTrigger('punch-main'), isTrue);
  });
}

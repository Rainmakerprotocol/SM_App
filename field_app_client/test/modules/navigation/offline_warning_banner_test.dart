import 'package:field_app_client/modules/navigation/presentation/navigation_shell.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Offline warning banner displays guidance message', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: OfflineWarningBanner())),
    );

    expect(
      find.text(
        'You are offline. Punches will sync when connection is restored.',
      ),
      findsOneWidget,
    );
    expect(
      find.byIcon(Icons.signal_wifi_connected_no_internet_4),
      findsOneWidget,
    );
  });
}

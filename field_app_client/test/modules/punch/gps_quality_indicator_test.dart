import 'package:field_app_client/modules/punch/presentation/punch_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

PunchStatus _status(int accuracy) => PunchStatus(
  isClockedIn: true,
  activeJob: 'Job',
  since: 'now',
  pendingSync: 0,
  gpsAccuracy: accuracy,
);

Widget _buildIndicator(int accuracy) {
  return MaterialApp(
    home: Scaffold(body: GpsQualityIndicator(status: _status(accuracy))),
  );
}

void main() {
  testWidgets('shows strong quality for <=20m accuracy', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildIndicator(15));
    expect(find.textContaining('Strong'), findsOneWidget);
    expect(find.byIcon(Icons.gps_fixed), findsOneWidget);
  });

  testWidgets('shows moderate quality for 20-80m accuracy', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildIndicator(50));
    expect(find.textContaining('Moderate'), findsOneWidget);
    expect(find.byIcon(Icons.gps_not_fixed), findsOneWidget);
  });

  testWidgets('shows weak quality for >80m accuracy', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(_buildIndicator(120));
    expect(find.textContaining('Weak'), findsOneWidget);
    expect(find.byIcon(Icons.gps_off), findsOneWidget);
  });
}

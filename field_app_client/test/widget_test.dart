import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:field_app_client/app/app.dart';

void main() {
  testWidgets('Login gate renders for unauthenticated users',
      (WidgetTester tester) async {
    await tester.pumpWidget(const ProviderScope(child: FieldApp()));

    expect(find.text('Storm Master Field App'), findsOneWidget);
    expect(find.text('Sign In'), findsOneWidget);
  });
}

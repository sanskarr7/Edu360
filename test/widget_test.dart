import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:edu_sms/main.dart';

void main() {
  testWidgets('Localization smoke test', (WidgetTester tester) async {
    // Build the app with the default locale and trigger a frame.
    await tester.pumpWidget(MyApp(const Locale('en')));

    // Verify that the login page renders correctly.
    expect(find.text('Sign In'), findsOneWidget); // Check for English localization
    expect(find.text('साइन इन गर्नुहोस्'), findsNothing);

    // Tap the dropdown and select the Nepali language.
    await tester.tap(find.byType(DropdownButton<Locale>));
    await tester.pumpAndSettle(); // Wait for the dropdown to appear.

    await tester.tap(find.text('नेपाली').last); // Tap on Nepali language.
    await tester.pumpAndSettle();

    // Verify that the localization changes to Nepali.
    expect(find.text('साइन इन गर्नुहोस्'), findsOneWidget); // Check for Nepali localization
    expect(find.text('Sign In'), findsNothing);
  });
}

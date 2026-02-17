// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gain_support/app.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: GainSupportApp()));

    // Verify that the main screen loads and shows the bottom navigation
    expect(find.byType(NavigationBar), findsOneWidget);

    // Verify Tickets are shown (loading might be instant or async)
    // Since we use Riverpod with async data, we might see a loading indicator first
    // await tester.pumpAndSettle(); // Wait for data

    // Check for Tickets tab
    expect(find.text('Tickets'), findsOneWidget);

    // Check for Contacts tab
    expect(find.text('Contacts'), findsOneWidget);

    // Check for Profile tab
    expect(find.text('Profile'), findsOneWidget);
  });
}

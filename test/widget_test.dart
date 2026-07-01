// Basic smoke test for the Hedzy e-commerce MVP app.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hegazy/main.dart';

void main() {
  testWidgets('Home screen shows brand title and best sellers section', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const HedzyApp());
    await tester.pump();

    expect(find.text('Hedzy'), findsWidgets);
    expect(find.text('Best Sellers'), findsOneWidget);

    // Toggling to list view should still keep the section visible.
    await tester.tap(find.byIcon(Icons.view_list_rounded));
    await tester.pump();
    expect(find.text('Best Sellers'), findsOneWidget);
  });
}

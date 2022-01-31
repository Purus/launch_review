// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:store_redirect_example/main.dart';

void main() {
  testWidgets("Locates the store redirect button", (WidgetTester tester) async {
    await tester.pumpWidget(MyApp());

    final buttonFinder = find.byType(ElevatedButton);
    final buttonTextFinder = find.text("Redirect App");

    expect(buttonFinder, findsOneWidget);
    expect(buttonTextFinder, findsOneWidget);
  });
}

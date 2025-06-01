// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:keepassxpress/main.dart';
import 'package:provider/provider.dart';
import 'package:keepassxpress/domain/providers/app_state.dart';

void main() {
  testWidgets('AppState theme toggle test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ChangeNotifierProvider(create: (_) => AppState(), child: MyApp()),
    );

    // Verify initial theme is light
    final MaterialApp materialApp = tester.widget(find.byType(MaterialApp));
    expect(materialApp.theme?.brightness, equals(Brightness.light));

    // Find and tap the theme toggle button
    await tester.tap(find.byIcon(Icons.brightness_6));
    await tester.pump();

    // Verify theme is now dark
    final MaterialApp updatedMaterialApp = tester.widget(
      find.byType(MaterialApp),
    );
    expect(updatedMaterialApp.theme?.brightness, equals(Brightness.dark));
  });
}

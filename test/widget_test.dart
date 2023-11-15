// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:stopwatch/main.dart';

void main() {
  testWidgets('Stopwatch tester', (WidgetTester tester) async {
    /// Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());
    expect(find.text('00:00.000'), findsOneWidget);

    /// Tap the '▶️' icon and wait then press '⏹'.
    await tester.tap(find.byIcon(Icons.play_arrow));
    await tester.pumpAndSettle(const Duration(milliseconds: 1000));
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('00:00.000'), findsNothing);
    // Tap the '⏹' icon twice.
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    await tester.tap(find.byIcon(Icons.stop));
    await tester.pumpAndSettle(const Duration(milliseconds: 100));
    expect(find.text('00:00.000'), findsOneWidget);
    expect(
      find.bySemanticsLabel("0 minutes 0 seconds 0 milliseconds"),
      findsOneWidget,
    );
    // Accessibility
    expect(tester, meetsGuideline(textContrastGuideline));
    expect(tester, meetsGuideline(androidTapTargetGuideline));
  });
  test("Time calculation", () {
    expect(calculateElapsed(0), equals('00:00.000'));
    expect(calculateElapsed(1), equals('00:00.001'));
    expect(calculateElapsed(10), equals('00:00.010'));
    expect(calculateElapsed(100), equals('00:00.100'));
    expect(calculateElapsed(1000), equals('00:01.000'));
    expect(calculateElapsed(10000), equals('00:10.000'));
    expect(calculateElapsed(60000), equals('01:00.000'));
  });
}

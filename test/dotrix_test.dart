import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dotrix/dotrix.dart';

void main() {
  testWidgets('Pulse renders without error', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Pulse())));
    expect(find.byType(Pulse), findsOneWidget);
  });

  testWidgets('Spinner renders without error', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Spinner())));
    expect(find.byType(Spinner), findsOneWidget);
  });

  testWidgets('Wave renders without error', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: Scaffold(body: Wave())));
    expect(find.byType(Wave), findsOneWidget);
  });
}

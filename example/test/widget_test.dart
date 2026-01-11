import 'package:flutter_test/flutter_test.dart';

import 'package:example/main.dart';

void main() {
  testWidgets('DemoPage renders without error', (WidgetTester tester) async {
    await tester.pumpWidget(const DotrixDemoApp());

    // Verify main elements exist
    expect(find.text('Dotrix Configuration'), findsOneWidget);
    expect(find.text('Pulse'), findsWidgets);
  });
}

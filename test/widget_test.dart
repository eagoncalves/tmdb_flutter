import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Find a text on main screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MaterialApp(
      home: Scaffold(
        body: Text('Home'),
      ),
    ));

    expect(find.text('Home'), findsOneWidget);
    // expect(find.text('M'), findsNothing);
  });
}

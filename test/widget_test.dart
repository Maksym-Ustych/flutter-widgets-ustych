import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_widgets_app/widgets/custom_button.dart';

void main() {
  testWidgets('CustomButton відображає текст і реагує на натискання',
      (WidgetTester tester) async {
    bool wasPressed = false;

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomButton(
            text: 'Тестова кнопка',
            icon: Icons.check,
            onPressed: () {
              wasPressed = true;
            },
          ),
        ),
      ),
    );

    expect(find.text('Тестова кнопка'), findsOneWidget);
    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(find.text('Тестова кнопка'));
    await tester.pump();

    expect(wasPressed, isTrue);
  });
}
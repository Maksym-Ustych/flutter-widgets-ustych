import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_widgets_app/models/product.dart';
import 'package:mobile_widgets_app/utils/app_state.dart';
import 'package:mobile_widgets_app/widgets/animated_counter.dart';
import 'package:mobile_widgets_app/widgets/custom_button.dart';

void main() {
  group('CustomButton tests', () {
    testWidgets(
      'CustomButton відображає текст та іконку',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(
                text: 'Тестова кнопка',
                icon: Icons.check,
                onPressed: () {},
              ),
            ),
          ),
        );

        expect(find.text('Тестова кнопка'), findsOneWidget);
        expect(find.byIcon(Icons.check), findsOneWidget);
      },
    );

    testWidgets(
      'CustomButton реагує на натискання',
      (WidgetTester tester) async {
        bool wasPressed = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: CustomButton(
                text: 'Натиснути',
                onPressed: () {
                  wasPressed = true;
                },
              ),
            ),
          ),
        );

        await tester.tap(find.text('Натиснути'));
        await tester.pump();

        expect(wasPressed, isTrue);
      },
    );
  });

  group('AnimatedCounter tests', () {
    testWidgets(
      'AnimatedCounter показує початкове значення',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AnimatedCounter(
                initialValue: 0,
                maxValue: 10,
              ),
            ),
          ),
        );

        expect(find.text('0'), findsOneWidget);
      },
    );

    testWidgets(
      'AnimatedCounter збільшує значення',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: AnimatedCounter(
                initialValue: 0,
                maxValue: 10,
              ),
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.add));
        await tester.pumpAndSettle();

        expect(find.text('1'), findsOneWidget);
      },
    );
  });

  group('AppState tests', () {
    test('addToCart збільшує кількість товарів у кошику', () {
      final appState = AppState();

      expect(appState.cartItemsCount, 0);

      appState.addToCart();

      expect(appState.cartItemsCount, 1);
    });

    test('toggleFavorite додає і видаляє товар з улюблених', () {
      final appState = AppState();

      const product = Product(
        name: 'Тестовий товар',
        description: 'Опис',
        price: 1000,
        imageUrl: 'https://example.com/product.jpg',
      );

      appState.toggleFavorite(product);

      expect(appState.isFavorite(product), isTrue);
      expect(appState.favoriteProducts.length, 1);

      appState.toggleFavorite(product);

      expect(appState.isFavorite(product), isFalse);
      expect(appState.favoriteProducts, isEmpty);
    });
  });
}
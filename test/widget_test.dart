import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:mobile_widgets_app/models/product.dart';
import 'package:mobile_widgets_app/models/user.dart';
import 'package:mobile_widgets_app/utils/app_state.dart';
import 'package:mobile_widgets_app/widgets/animated_counter.dart';
import 'package:mobile_widgets_app/widgets/custom_button.dart';
import 'package:mobile_widgets_app/widgets/product_card.dart';
import 'package:mobile_widgets_app/widgets/profile_widget.dart';

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

    testWidgets(
      'CustomButton показує loading state',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: CustomButton(
                text: 'Завантаження',
                onPressed: null,
                isLoading: true,
              ),
            ),
          ),
        );

        expect(
          find.byType(CircularProgressIndicator),
          findsOneWidget,
        );
      },
    );
  });

  group('ProfileWidget tests', () {
    const user = User(
      name: 'Максим Устич',
      email: 'maksym@example.com',
      avatarUrl: 'https://example.com/avatar.jpg',
    );

    testWidgets(
      'ProfileWidget відображає імʼя та email',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ProfileWidget(
                user: user,
              ),
            ),
          ),
        );

        expect(find.text('Максим Устич'), findsOneWidget);
        expect(find.text('maksym@example.com'), findsOneWidget);
      },
    );

    testWidgets(
      'ProfileWidget підтримує compact режим',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: ProfileWidget(
                user: user,
                isCompact: true,
              ),
            ),
          ),
        );

        expect(find.text('Максим Устич'), findsOneWidget);
        expect(find.text('maksym@example.com'), findsOneWidget);
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

  group('ProductCard tests', () {
    const product = Product(
      name: 'Ноутбук',
      description: 'Тестовий опис товару',
      price: 29999,
      originalPrice: 32999,
      imageUrl: 'https://example.com/laptop.jpg',
    );

    testWidgets(
      'ProductCard відображає дані товару',
      (WidgetTester tester) async {
        await tester.pumpWidget(
          const MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ProductCard(
                  product: product,
                ),
              ),
            ),
          ),
        );

        expect(find.text('Ноутбук'), findsOneWidget);
        expect(
          find.text('Тестовий опис товару'),
          findsOneWidget,
        );
        expect(find.text('29999.00 грн'), findsOneWidget);
        expect(find.text('32999.00 грн'), findsOneWidget);
        expect(find.text('Додати в кошик'), findsOneWidget);
      },
    );

    testWidgets(
      'ProductCard викликає onAddToCart',
      (WidgetTester tester) async {
        bool addedToCart = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ProductCard(
                  product: product,
                  onAddToCart: () {
                    addedToCart = true;
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.text('Додати в кошик'));
        await tester.pump();

        expect(addedToCart, isTrue);
      },
    );

    testWidgets(
      'ProductCard викликає onFavoriteToggle',
      (WidgetTester tester) async {
        bool favoriteChanged = false;

        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ProductCard(
                  product: product,
                  onFavoriteToggle: () {
                    favoriteChanged = true;
                  },
                ),
              ),
            ),
          ),
        );

        await tester.tap(find.byIcon(Icons.favorite_border));
        await tester.pump();

        expect(favoriteChanged, isTrue);
      },
    );
  });

  group('AppState tests', () {
    test('addToCart збільшує кількість товарів у кошику', () {
      final appState = AppState();

      const product = Product(
        name: 'Тестовий товар',
        description: 'Опис товару',
        price: 1000,
        imageUrl: 'https://example.com/product.jpg',
      );

      expect(appState.cartItemsCount, 0);

      appState.addToCart(product);

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
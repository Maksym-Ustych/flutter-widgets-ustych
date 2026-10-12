import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';

import 'package:mobile_widgets_app/main.dart' as app;

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  testWidgets(
    'Основний користувацький сценарій застосунку',
    (WidgetTester tester) async {
      // Запуск застосунку
      app.main();
      await tester.pump(const Duration(seconds: 2));

      // Перевірка головного екрана
      expect(find.text('Головна'), findsWidgets);
      expect(find.text('CustomButton'), findsOneWidget);

      // Перехід до товарів
      await tester.tap(find.text('Товари'));
      await tester.pump(const Duration(milliseconds: 800));

      // Перевірка екрана товарів
      expect(find.text('Ноутбук'), findsOneWidget);
      expect(find.text('Смартфон'), findsOneWidget);

      // Додавання товару в кошик
      await tester.tap(
        find.text('Додати в кошик').first,
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.textContaining('додано в кошик'),
        findsOneWidget,
      );

      // Додавання товару в улюблені
      await tester.tap(
        find.byIcon(Icons.favorite_border).first,
      );
      await tester.pump(const Duration(milliseconds: 500));

      expect(
        find.byIcon(Icons.favorite),
        findsWidgets,
      );

      // Перехід до профілю
      await tester.tap(find.text('Профіль').last);
      await tester.pump(const Duration(milliseconds: 800));

      expect(
        find.text('Максим Устич'),
        findsOneWidget,
      );

      expect(
        find.text('maksym.ustych@example.com'),
        findsOneWidget,
      );
    },
  );
}
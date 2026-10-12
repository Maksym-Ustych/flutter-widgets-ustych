# Test Coverage Report

## Загальна інформація

Для перевірки проєкту використано Flutter unit та widget tests.

Команди перевірки:

```bash
flutter analyze
flutter test
flutter test --coverage
```

## Результат тестування

- Кількість тестів: 12
- Результат: All tests passed
- Code analysis: No issues found
- Coverage: 72.7%
- Покрито рядків: 205 із 282

## Протестовані компоненти

### CustomButton

Перевірено:

- відображення тексту та іконки;
- реакцію на натискання;
- loading state.

### ProfileWidget

Перевірено:

- відображення імені та email;
- expanded режим;
- compact режим.

### AnimatedCounter

Перевірено:

- початкове значення;
- збільшення значення.

### ProductCard

Перевірено:

- відображення даних товару;
- додавання товару до кошика;
- favorite interaction.

### AppState

Перевірено:

- збільшення кількості товарів у кошику;
- додавання та видалення товару з улюблених.

## Coverage файл

Flutter створює звіт у файлі:

```text
coverage/lcov.info
```

Актуальний результат:

```text
Coverage: 72.7% (205/282 lines)
```

## Висновок

Усі створені тести проходять успішно. Основні custom widgets та state management перевірені автоматичними тестами.
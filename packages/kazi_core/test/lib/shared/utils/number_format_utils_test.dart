import 'dart:ui';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi_core/kazi_core.dart';

void main() {
  group('formatCurrencyIn', () {
    test('formats an int with pt_BR separators', () {
      final result = NumberFormatUtils.formatCurrencyIn(
        22,
        SupportedCurrency.brl,
        locale: const Locale('pt', 'BR'),
      );

      expect(result, equals('R\$\u{00A0}22,00'));
    });

    test('formats a double with pt_BR separators', () {
      final result = NumberFormatUtils.formatCurrencyIn(
        17452.57,
        SupportedCurrency.brl,
        locale: const Locale('pt', 'BR'),
      );

      expect(result, equals('R\$\u{00A0}17.452,57'));
    });

    test('formats with en_US separators', () {
      final result = NumberFormatUtils.formatCurrencyIn(
        7899945.357,
        SupportedCurrency.usd,
        locale: const Locale('en', 'US'),
      );

      expect(result, equalsIgnoringWhitespace('\$7,899,945.36'));
    });

    test('uses the currency, not the locale, to pick the symbol', () {
      // A pt_BR device showing an amount registered in USD must not label it
      // R$ — that was the bug the locale-derived formatter caused.
      final result = NumberFormatUtils.formatCurrencyIn(
        10,
        SupportedCurrency.usd,
        locale: const Locale('pt', 'BR'),
      );

      expect(result.contains('\$'), isTrue);
      expect(result.contains('R\$'), isFalse);
    });

    test('honours a zero-decimal currency', () {
      final result = NumberFormatUtils.formatCurrencyIn(
        1500,
        SupportedCurrency.ugx,
        locale: const Locale('en', 'US'),
      );

      expect(result, equalsIgnoringWhitespace('USh1,500'));
    });

    test('treats a null value as zero', () {
      final result = NumberFormatUtils.formatCurrencyIn(
        null,
        SupportedCurrency.usd,
        locale: const Locale('en', 'US'),
      );

      expect(result, equalsIgnoringWhitespace('\$0.00'));
    });
  });

  group('getCurrentLocale', () {
    tearDown(() => Intl.defaultLocale = null);

    test('follows the app language over the device locale', () {
      // The test device is en_US; the app is in Portuguese.
      Intl.defaultLocale = 'pt';

      final result = NumberFormatUtils.formatCurrencyIn(
        1234.5,
        SupportedCurrency.brl,
      );

      expect(result, equals('R\$\u{00A0}1.234,50'));
    });

    test('keeps the device region when it shares the app language', () {
      Intl.defaultLocale = 'en';

      expect(NumberFormatUtils.getCurrentLocale(), equals('en_US'));
    });
  });
}

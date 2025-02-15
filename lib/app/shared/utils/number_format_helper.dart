import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';

abstract class NumberFormatHelper {
  static String formatCurrency(BuildContext context,
      [num? value, Locale? locale,]) {
    final stringLocale = locale != null
        ? '${locale.languageCode}_${locale.countryCode}'
        : getCurrentLocale();
    return NumberFormat.currency(
            locale: stringLocale, symbol: _getCurrencySymbol(context, locale),)
        .format(value ?? 0);
  }

  static String _getCurrencySymbol(BuildContext context, Locale? locale) {
    return NumberFormat.simpleCurrency(
            locale: (locale ?? Localizations.localeOf(context)).toString(),)
        .currencySymbol;
  }

  static String formatPercent([double? value, Locale? locale]) {
    final valueWithoutZero = value?.removeDecimalPoint() ?? '0';
    var decimalDigits = 0;
    final splitted = valueWithoutZero.split('.');
    if (splitted.length > 1) {
      decimalDigits = splitted[1].length;
    }

    final stringLocale = locale != null
        ? '${locale.languageCode}_${locale.countryCode}'
        : getCurrentLocale();
    return NumberFormat.decimalPercentPattern(
            locale: stringLocale, decimalDigits: decimalDigits,)
        .format((double.tryParse(valueWithoutZero) ?? 0) / 100);
  }

  static String getCurrentLocale() {
    final locale = PlatformDispatcher.instance.locale;
    final joined = '${locale.languageCode}_${locale.countryCode}';
    if (numberFormatSymbols.keys.contains(joined)) {
      return joined;
    }
    return locale.languageCode;
  }

  static String getDecimalSeparator() {
    return numberFormatSymbols[getCurrentLocale()]?.DECIMAL_SEP ?? ',';
  }

  static String getThousandSeparator() {
    return numberFormatSymbols[getCurrentLocale()]?.GROUP_SEP ?? '.';
  }

  static String getCurrencySymbol() {
    final format = NumberFormat.simpleCurrency(locale: getCurrentLocale());
    return format.currencySymbol;
  }
}

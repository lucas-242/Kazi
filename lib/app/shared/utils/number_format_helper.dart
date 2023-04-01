import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';

abstract class NumberFormatHelper {
  static String formatCurrency(BuildContext context,
      [num? value, Locale? locale]) {
    final stringLocale =
        locale != null ? '${locale.languageCode}_${locale.countryCode}' : null;
    return NumberFormat.currency(
            locale: stringLocale, symbol: _getCurrencySymbol(context, locale))
        .format(value ?? 0);
  }

  static String _getCurrencySymbol(BuildContext context, Locale? locale) {
    return NumberFormat.simpleCurrency(
            locale: (locale ?? Localizations.localeOf(context)).toString())
        .currencySymbol;
  }

  static String formatPercent([double? value, Locale? locale]) {
    final valueWithoutZero = value?.removeDecimalPoint() ?? '0';
    var decimalDigits = 0;
    final splitted = valueWithoutZero.split('.');
    if (splitted.length > 1) {
      decimalDigits = splitted[1].length;
    }

    final stringLocale =
        locale != null ? '${locale.languageCode}_${locale.countryCode}' : null;
    return NumberFormat.decimalPercentPattern(
            locale: stringLocale, decimalDigits: decimalDigits)
        .format((double.tryParse(valueWithoutZero) ?? 0) / 100);
  }
}

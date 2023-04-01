import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

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
}

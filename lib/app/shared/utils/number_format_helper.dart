import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

abstract class NumberFormatHelper {
  static String formatCurrency(BuildContext context, [num? value]) {
    return NumberFormat.currency(symbol: getCurrencySymbol(context))
        .format(value ?? 0);
  }

  static String getCurrencySymbol(BuildContext context) {
    return NumberFormat.simpleCurrency(
            locale: Localizations.localeOf(context).toString())
        .currencySymbol;
  }
}

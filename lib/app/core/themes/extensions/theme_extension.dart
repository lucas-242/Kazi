import 'package:flutter/material.dart';
import 'package:kazi/app/core/widgets/layout/custom_snack_bar/custom_snack_bar.dart';

export 'package:kazi/app/core/widgets/layout/custom_snack_bar/custom_snack_bar.dart'
    hide showCustomSnackBar;

extension ThemeExtension on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorsScheme => theme.colorScheme;

  double get width => _mediaQuery.size.width;
  double get height => _mediaQuery.size.height;

  void showSnackBar(
    String message, {
    SnackBarType type = SnackBarType.error,
    bool horizontalMargin = true,
  }) =>
      showCustomSnackBar(this, message,
          horizontalMargin: horizontalMargin, type: type);
}

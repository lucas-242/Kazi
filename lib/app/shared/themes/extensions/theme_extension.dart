import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  MediaQueryData get _mediaQuery => MediaQuery.of(this);
  ThemeData get theme => Theme.of(this);
  ColorScheme get colorsScheme => theme.colorScheme;

  double get width => _mediaQuery.size.width;
  double get height => _mediaQuery.size.height;
  double get topBarHeight => _mediaQuery.padding.top + kToolbarHeight;

  bool get isKeyboardOpen => _mediaQuery.viewInsets.bottom > 0;
}

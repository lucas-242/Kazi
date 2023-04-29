import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TypographyExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get _textTheme => _theme.textTheme;
  ColorScheme get _colors => _theme.colorScheme;

  TextStyle? get cardTitle => GoogleFonts.outfit(
        color: _colors.background,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );

  TextStyle? get cardSubtitle => GoogleFonts.outfit(
        color: _colors.background,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  TextStyle? get appBarTitle => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle? get loginTitle => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 36,
      );

  TextStyle? get headlineLarge => _textTheme.headlineLarge;
  TextStyle? get headlineMedium => _textTheme.headlineMedium;
  TextStyle? get headlineSmall => _textTheme.headlineSmall;

  TextStyle? get titleMedium => _textTheme.titleMedium;
  TextStyle? get titleSmall => _textTheme.titleSmall;

  TextStyle? get bodyLarge => _textTheme.bodyLarge;
  TextStyle? get bodyMedium => _textTheme.bodyMedium;
  TextStyle? get bodySmall => _textTheme.bodySmall;

  TextStyle? get labelLarge => _textTheme.labelLarge;
  TextStyle? get labelMedium => _textTheme.labelMedium;
  TextStyle? get labelSmall => _textTheme.labelSmall;
}

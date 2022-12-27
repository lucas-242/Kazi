import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

extension TypographyExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get _textTheme => GoogleFonts.poppinsTextTheme(_theme.textTheme);
  ColorScheme get _colors => _theme.colorScheme;

  TextStyle? get displayLarge => _textTheme.displayLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get displayMedium => _textTheme.displayMedium?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get displaySmall => _textTheme.displaySmall?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get headlineLarge => _textTheme.headlineLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get headlineMedium => _textTheme.headlineMedium?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get headlineSmall => _textTheme.headlineSmall?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get titleLarge => _textTheme.titleLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get titleMedium => _textTheme.titleMedium?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get titleSmall => _textTheme.titleSmall?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get labelLarge => _textTheme.labelLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get labelMedium => _textTheme.labelMedium?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get labelSmall => _textTheme.labelSmall?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get bodyLarge => _textTheme.bodyLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get bodyMedium => _textTheme.bodyMedium?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get bodySmall => _textTheme.bodySmall?.copyWith(
        color: _colors.onSurface,
      );
}

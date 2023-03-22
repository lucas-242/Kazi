import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_services/app/shared/themes/themes.dart';

extension TypographyExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  TextTheme get _textTheme => GoogleFonts.outfitTextTheme(_theme.textTheme);
  ColorScheme get _colors => _theme.colorScheme;

  TextStyle? get cardTitle => _textTheme.bodyMedium?.copyWith(
        color: _colors.background,
        fontWeight: FontWeight.w500,
        fontSize: 22,
      );

  TextStyle? get cardSubtitle => _textTheme.bodyMedium?.copyWith(
        color: _colors.background,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  TextStyle? get tileTitle => _textTheme.bodyMedium?.copyWith(
        color: _colors.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  TextStyle? get noData => _textTheme.bodyMedium?.copyWith(
        color: AppColors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );

  TextStyle? get headlineLarge => _textTheme.headlineLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get headlineSmall => _textTheme.headlineSmall?.copyWith(
        color: _colors.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );
  TextStyle? get titleLarge => _textTheme.titleLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get titleMedium => _textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle? get titleSmall => _textTheme.titleSmall?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get bodyLarge => _textTheme.bodyLarge?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get bodyMedium => _textTheme.bodyMedium?.copyWith(
        color: _colors.onSurface,
      );
  TextStyle? get bodySmall => _textTheme.bodySmall?.copyWith(
        color: AppColors.grey,
        fontSize: 12,
      );
}

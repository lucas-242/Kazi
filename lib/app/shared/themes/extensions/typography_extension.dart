import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_services/app/shared/themes/themes.dart';

extension TypographyExtension on BuildContext {
  ThemeData get _theme => Theme.of(this);
  // TextTheme get _textTheme => _theme.textTheme;
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

  TextStyle? get noData => GoogleFonts.outfit(
        color: AppColors.grey,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );

  TextStyle? get headlineLarge => GoogleFonts.outfit(
        color: _colors.onSurface,
      );
  TextStyle? get headlineSmall => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 18,
      );

  TextStyle? get titleLarge => GoogleFonts.outfit(
        color: _colors.onSurface,
      );
  TextStyle? get titleMedium => GoogleFonts.outfit(
        fontWeight: FontWeight.w500,
        fontSize: 20,
      );
  TextStyle? get titleSmall => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      );

  TextStyle? get bodyLarge => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 18,
      );
  TextStyle? get bodyMedium => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 16,
      );
  TextStyle? get bodySmall => GoogleFonts.outfit(
        color: _colors.onSurface,
        fontWeight: FontWeight.w400,
        fontSize: 14,
      );

  TextStyle? get labelLarge => GoogleFonts.outfit(
        color: AppColors.grey,
        fontSize: 16,
      );
  TextStyle? get labelMedium => GoogleFonts.outfit(
        color: AppColors.grey,
        fontSize: 14,
      );
  TextStyle? get labelSmall => GoogleFonts.outfit(
        color: AppColors.grey,
        fontSize: 12,
      );

  //! Commented because .copyWith for fontWeight isn't working
  // TextStyle? get cardTitle => _textTheme.bodyMedium?.copyWith(
  //       color: _colors.background,
  //       fontWeight: FontWeight.w500,
  //       fontSize: 22,
  //     );

  // TextStyle? get cardSubtitle => _textTheme.bodyMedium?.copyWith(
  //       color: _colors.background,
  //       fontWeight: FontWeight.w500,
  //       fontSize: 16,
  //     );

  // TextStyle? get noData => _textTheme.bodyMedium?.copyWith(
  //       color: AppColors.grey,
  //       fontWeight: FontWeight.w400,
  //       fontSize: 18,
  //     );

  // TextStyle? get headlineLarge => _textTheme.headlineLarge?.copyWith(
  //       color: _colors.onSurface,
  //     );
  // TextStyle? get headlineSmall => _textTheme.headlineSmall?.copyWith(
  //       color: _colors.onSurface,
  //       fontWeight: FontWeight.w500,
  //       fontSize: 18,
  //     );

  // TextStyle? get titleLarge => _textTheme.titleLarge?.copyWith(
  //       color: _colors.onSurface,
  //     );

  // TextStyle? get titleMedium => _textTheme.titleMedium?.copyWith(
  //       fontWeight: FontWeight.w500,
  //       fontSize: 20,
  //     );

  // TextStyle? get titleSmall => _textTheme.titleSmall?.copyWith(
  //       color: _colors.onSurface,
  //       fontWeight: FontWeight.w500,
  //       fontSize: 16,
  //     );

  // TextStyle? get bodyLarge => _textTheme.bodyMedium?.copyWith(
  //       color: _colors.onSurface,
  //       fontWeight: FontWeight.w400,
  //       fontSize: 16,
  //     );
  // TextStyle? get bodyMedium => _textTheme.bodyMedium?.copyWith(
  //       color: _colors.onSurface,
  //       fontWeight: FontWeight.w400,
  //       fontSize: 14,
  //     );

  // TextStyle? get labelMedium => _textTheme.labelMedium?.copyWith(
  //       color: AppColors.grey,
  //       fontSize: 14,
  //     );
  // TextStyle? get labelSmall => _textTheme.labelSmall?.copyWith(
  //       color: AppColors.grey,
  //       fontSize: 12,
  //     );
}

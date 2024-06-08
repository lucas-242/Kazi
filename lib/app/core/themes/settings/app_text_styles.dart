import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kazi/app/core/themes/themes.dart';

abstract class AppTextStyles {
  static final cardTitle = GoogleFonts.outfit(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 22,
  );

  static final cardSubtitle = GoogleFonts.outfit(
    color: AppColors.white,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );

  static final appBarTitle = GoogleFonts.outfit(
    color: AppColors.black,
    fontWeight: FontWeight.w400,
    fontSize: 18,
  );

  static final loginTitle = GoogleFonts.outfit(
    color: AppColors.black,
    fontWeight: FontWeight.w500,
    fontSize: 36,
  );

  static final headlineLg = textTheme.headlineLarge;
  static final headlineMd = textTheme.headlineMedium;
  static final headlineSm = textTheme.headlineSmall;

  static final titleMd = textTheme.titleMedium;
  static final titleSm = textTheme.titleSmall;

  static final lg = textTheme.bodyLarge;
  static final md = textTheme.bodyMedium;
  static final sm = textTheme.bodySmall;

  static final labelLg = textTheme.labelLarge;
  static final labelMd = textTheme.labelMedium;
  static final labelSm = textTheme.labelSmall;

  static final textTheme = TextTheme(
    displayLarge: GoogleFonts.outfit(),
    displayMedium: GoogleFonts.outfit(),
    displaySmall: GoogleFonts.outfit(),
    headlineLarge: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 32,
    ),
    headlineMedium: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 24,
    ),
    headlineSmall: GoogleFonts.outfit(
      color: AppColors.grey,
      fontWeight: FontWeight.w500,
      fontSize: 18,
    ),
    titleLarge: GoogleFonts.outfit(),
    titleMedium: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 20,
    ),
    titleSmall: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w500,
      fontSize: 16,
    ),
    bodyLarge: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 18,
    ),
    bodyMedium: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    bodySmall: GoogleFonts.outfit(
      color: AppColors.black,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    labelLarge: GoogleFonts.outfit(
      color: AppColors.grey,
      fontWeight: FontWeight.w400,
      fontSize: 16,
    ),
    labelMedium: GoogleFonts.outfit(
      color: AppColors.grey,
      fontWeight: FontWeight.w400,
      fontSize: 14,
    ),
    labelSmall: GoogleFonts.outfit(
      color: AppColors.grey,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
  );
}

import 'package:flutter/material.dart';

class ThemeSettings {
  const ThemeSettings({
    required this.backgroundColor,
    required this.sourceColor,
    required this.textColor,
    required this.themeMode,
  });

  final Color backgroundColor;
  final Color sourceColor;
  final Color textColor;
  final ThemeMode themeMode;
}

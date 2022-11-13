import 'package:flutter/material.dart';

class ThemeSettings {
  ThemeSettings({
    required this.sourceColor,
    required this.themeMode,
  });

  final Color sourceColor;
  final ThemeMode themeMode;
}

ThemeSettings get defaultThemeSettings => ThemeSettings(
    sourceColor: const Color.fromARGB(255, 255, 175, 204),
    themeMode: ThemeMode.system);

import 'package:flutter/material.dart';

import '../models/theme_settings.dart';

ThemeSettings get darkThemeSettings => const ThemeSettings(
      sourceColor: Color.fromARGB(255, 255, 204, 49),
      themeMode: ThemeMode.light,
    );

ThemeSettings get lightThemeSettings => const ThemeSettings(
      sourceColor: Color.fromARGB(255, 255, 204, 49),
      themeMode: ThemeMode.light,
    );

import 'package:flutter/material.dart';

import '../models/theme_settings.dart';

ThemeSettings get darkThemeSettings => const ThemeSettings(
      sourceColor: Color.fromARGB(255, 49, 15, 92),
      themeMode: ThemeMode.light,
    );

ThemeSettings get lightThemeSettings => const ThemeSettings(
      sourceColor: Color.fromARGB(255, 179, 136, 235),
      themeMode: ThemeMode.light,
    );

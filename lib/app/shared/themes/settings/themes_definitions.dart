import 'package:flutter/material.dart';

import '../models/theme_settings.dart';

ThemeSettings get darkThemeSettings => const ThemeSettings(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      sourceColor: Color.fromARGB(255, 255, 204, 49),
      textColor: Color.fromARGB(255, 255, 255, 255),
      themeMode: ThemeMode.light,
    );

ThemeSettings get lightThemeSettings => const ThemeSettings(
      backgroundColor: Color.fromARGB(255, 250, 250, 250),
      sourceColor: Color.fromARGB(255, 255, 204, 49),
      textColor: Color.fromARGB(255, 31, 31, 31),
      themeMode: ThemeMode.light,
    );

import 'package:flutter/material.dart';

import 'theme_provider.dart';

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(ThemeProvider theme) {
    return theme.customizeColor(this);
  }
}

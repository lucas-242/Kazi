import 'package:flutter/material.dart';

import '../services/theme_service.dart';

class CustomColor {
  const CustomColor({
    required this.name,
    required this.color,
    this.blend = true,
  });

  final String name;
  final Color color;
  final bool blend;

  Color value(ThemeService theme) {
    return theme.customizeColor(this);
  }
}

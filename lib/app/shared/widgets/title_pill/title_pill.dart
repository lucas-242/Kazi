import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/themes/themes.dart';

import '../pill_button/pill_button.dart';

class TitlePill extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String button;

  const TitlePill(
      {super.key,
      required this.onTap,
      required this.button,
      required this.title});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title.capitalize(), style: context.titleMedium),
        PillButton(
          onTap: onTap,
          backgroundColor: context.colorsScheme.onSurface,
          foregroundColor: context.colorsScheme.background,
          text: button,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/themes/themes.dart';

import 'pill_button.dart';

class TitleAndPill extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final String pillText;

  const TitleAndPill({
    super.key,
    required this.title,
    required this.onTap,
    required this.pillText,
  });

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
          child: Text(pillText),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/themes/themes.dart';

import 'pill_button.dart';

class BackAndPill extends StatelessWidget {
  final VoidCallback onTapBack;
  final VoidCallback onTapPill;
  final String pillText;

  const BackAndPill({
    super.key,
    required this.pillText,
    required this.onTapBack,
    required this.onTapPill,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PillButton(
          onTap: onTapBack,
          backgroundColor: context.colorsScheme.onSurface,
          foregroundColor: context.colorsScheme.background,
          child: const Icon(Icons.chevron_left),
        ),
        PillButton(
          onTap: onTapPill,
          backgroundColor: context.colorsScheme.onSurface,
          foregroundColor: context.colorsScheme.background,
          child: Text(pillText),
        ),
      ],
    );
  }
}

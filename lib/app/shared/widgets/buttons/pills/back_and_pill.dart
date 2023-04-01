import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/circular_button/circular_button.dart';

import 'pill_button.dart';

class BackAndPill extends StatelessWidget {
  final VoidCallback onTapPill;
  final String? text;
  final String pillText;

  const BackAndPill({
    super.key,
    required this.pillText,
    required this.onTapPill,
    this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircularButton(
              onTap: () => context.pop(),
              child: const Icon(Icons.chevron_left),
            ),
            AppSizeConstants.smallHorizontalSpacer,
            Visibility(
              visible: text != null,
              child: Text(
                text ?? '',
                style: context.titleMedium,
              ),
            )
          ],
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

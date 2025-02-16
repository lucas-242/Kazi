import 'package:flutter/material.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/circular_button/circular_button.dart';

import 'pill_button.dart';

class BackAndPill extends StatelessWidget {

  const BackAndPill({
    super.key,
    this.pillText,
    this.onTapPill,
    this.text,
    this.foregroundColor,
    this.backgroundColor,
    this.onTapBack,
  });
  final VoidCallback? onTapBack;
  final VoidCallback? onTapPill;
  final String? text;
  final String? pillText;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircularButton(
              onTap: () => onTapBack != null ? onTapBack!() : context.back(),
              child: const Icon(Icons.chevron_left),
            ),
            AppSizeConstants.smallHorizontalSpacer,
            Visibility(
              visible: text != null,
              child: Text(
                text ?? '',
                style: context.titleMedium,
              ),
            ),
          ],
        ),
        Visibility(
          visible: pillText != null && pillText!.isNotEmpty,
          child: PillButton(
            onTap: onTapPill,
            backgroundColor: backgroundColor ?? context.colorsScheme.onSurface,
            foregroundColor: foregroundColor ?? context.colorsScheme.surface,
            child: Text(pillText ?? ''),
          ),
        ),
      ],
    );
  }
}

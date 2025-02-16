import 'package:flutter/material.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/circular_button/circular_button.dart';

class BackAndPills extends StatelessWidget {

  const BackAndPills({
    super.key,
    this.onTapPill1,
    this.text,
    this.onTapBack,
    this.pills,
  });
  final VoidCallback? onTapBack;
  final VoidCallback? onTapPill1;
  final String? text;
  final List<Widget>? pills;

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
        if (pills != null)
          Row(
            children: pills!,
          ),
      ],
    );
  }
}

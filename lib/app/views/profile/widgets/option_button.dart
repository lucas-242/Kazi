import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/texts/texts.dart';

class OptionButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final TextStyle? textStyle;
  const OptionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        children: [
          AppSizeConstants.largeVerticalSpacer,
          TextWithTrailing(
            text: text,
            textStyle: textStyle ?? context.titleSmall,
            trailing: const Icon(
              Icons.chevron_right,
              color: AppColors.grey,
            ),
          ),
          AppSizeConstants.largeVerticalSpacer,
        ],
      ),
    );
  }
}
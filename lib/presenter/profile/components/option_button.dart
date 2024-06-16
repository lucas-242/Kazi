import 'package:flutter/material.dart';
import 'package:kazi/core/components/texts/texts.dart';
import 'package:kazi_design_system/themes/themes.dart';

class OptionButton extends StatelessWidget {
  const OptionButton({
    super.key,
    required this.onTap,
    required this.text,
    this.textStyle,
  });
  final VoidCallback onTap;
  final String text;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(KaziInsets.lg),
        child: TextWithTrailing(
          text: text,
          textStyle: textStyle ?? context.titleSmall,
          trailing: const Icon(
            Icons.chevron_right,
            color: KaziColors.grey,
          ),
        ),
      ),
    );
  }
}

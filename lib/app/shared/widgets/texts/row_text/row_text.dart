import 'package:flutter/material.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class RowText extends StatelessWidget {
  final String leftText;
  final String rightText;
  final TextStyle? leftTextStyle;
  final TextStyle? rightTextStyle;
  const RowText({
    super.key,
    required this.leftText,
    required this.rightText,
    this.leftTextStyle,
    this.rightTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftText,
          style: leftTextStyle ?? context.titleSmall,
        ),
        Text(
          rightText,
          style: rightTextStyle ?? context.titleSmall,
        )
      ],
    );
  }
}

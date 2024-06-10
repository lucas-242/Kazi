import 'package:flutter/material.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/themes/themes.dart';

class TextWithTrailing extends StatelessWidget {
  const TextWithTrailing({
    super.key,
    required this.text,
    required this.trailing,
    this.textStyle,
  });
  final String text;
  final Widget trailing;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text.capitalize(),
          style: textStyle ?? context.titleMedium,
        ),
        trailing
      ],
    );
  }
}

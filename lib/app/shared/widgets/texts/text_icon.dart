import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class TextIcon extends StatelessWidget {
  final String text;
  final IconData icon;
  final TextStyle? textStyle;
  const TextIcon({
    super.key,
    required this.text,
    required this.icon,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          text,
          style: textStyle ?? context.titleSmall,
        ),
        Icon(
          icon,
          color: AppColors.grey,
        )
      ],
    );
  }
}

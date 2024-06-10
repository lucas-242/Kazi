import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';

class SelectablePillButton extends StatelessWidget {
  const SelectablePillButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.isSelected});
  final VoidCallback onTap;
  final String text;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return PillButton(
      onTap: onTap,
      backgroundColor: isSelected ? AppColors.black : AppColors.grey,
      child: Text(text),
    );
  }
}

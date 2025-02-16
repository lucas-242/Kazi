import 'package:flutter/material.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';

class SelectablePillButton extends StatelessWidget {
  const SelectablePillButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.isSelected,});
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

import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';

class SelectablePillButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;
  const SelectablePillButton(
      {super.key,
      required this.onTap,
      required this.text,
      required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return PillButton(
      onTap: onTap,
      backgroundColor: isSelected ? AppColors.black : AppColors.grey,
      child: Text(text),
    );
  }
}

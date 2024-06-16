import 'package:flutter/material.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
    return KaziPillButton(
      onTap: onTap,
      backgroundColor: isSelected ? KaziColors.black : KaziColors.grey,
      child: Text(text),
    );
  }
}

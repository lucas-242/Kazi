import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class SelectableTag extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final bool isSelected;

  const SelectableTag({
    Key? key,
    required this.onTap,
    required this.text,
    this.isSelected = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ButtonStyle(
        backgroundColor: isSelected
            ? MaterialStateProperty.all<Color>(
                context.colorsScheme.secondaryContainer)
            : null,
        foregroundColor:
            MaterialStateProperty.all<Color>(context.colorsScheme.surfaceTint),
      ),
      child: Text(text),
    );
  }
}

import 'package:flutter/material.dart';
import '../../themes/themes.dart';

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
            : MaterialStateProperty.all<Color>(Colors.transparent),
        foregroundColor: isSelected
            ? MaterialStateProperty.all<Color>(
                context.colorsScheme.onSecondaryContainer)
            : MaterialStateProperty.all<Color>(
                context.colorsScheme.onBackground),
      ),
      child: Text(text),
    );
  }
}

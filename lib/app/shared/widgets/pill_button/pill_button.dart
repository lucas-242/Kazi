import 'package:flutter/material.dart';

class PillButton extends StatelessWidget {
  final VoidCallback onTap;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const PillButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        )),
        backgroundColor: backgroundColor != null
            ? MaterialStateProperty.all<Color>(backgroundColor!)
            : null,
        foregroundColor: foregroundColor != null
            ? MaterialStateProperty.all<Color>(foregroundColor!)
            : null,
      ),
      child: Text(text),
    );
  }
}

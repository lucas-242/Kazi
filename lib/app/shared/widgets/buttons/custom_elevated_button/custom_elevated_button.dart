import 'package:flutter/material.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class CustomElevatedButton extends StatelessWidget {

  const CustomElevatedButton({
    super.key,
    required this.onTap,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.height,
  });
  final VoidCallback onTap;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all<Size>(Size(
            width ?? context.width * 0.7, height ?? context.height * 0.067,),),
        backgroundColor: backgroundColor != null
            ? WidgetStateProperty.all<Color>(backgroundColor!)
            : null,
        foregroundColor: foregroundColor != null
            ? WidgetStateProperty.all<Color>(foregroundColor!)
            : null,
      ),
      child: Text(text),
    );
  }
}

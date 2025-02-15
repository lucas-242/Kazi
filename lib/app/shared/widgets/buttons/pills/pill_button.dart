import 'package:flutter/material.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
  });
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      key: key,
      onPressed: onTap,
      style: ButtonStyle(
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),),
        minimumSize: WidgetStateProperty.all<Size>(const Size(5, 35)),
        backgroundColor: WidgetStateProperty.all<Color>(
          backgroundColor != null
              ? backgroundColor!
              : context.colorsScheme.onSurface,
        ),
        foregroundColor: WidgetStateProperty.all<Color>(
          foregroundColor != null
              ? foregroundColor!
              : context.colorsScheme.surface,
        ),
      ),
      child: child,
    );
  }
}

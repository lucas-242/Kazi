import 'package:flutter/material.dart';
import 'package:kazi/app/core/themes/themes.dart';

class PillButton extends StatelessWidget {
  const PillButton({
    super.key,
    required this.onTap,
    required this.child,
    this.backgroundColor,
    this.foregroundColor,
    this.fillWidth = false,
    this.outlinedButton = false,
    this.width,
  });
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool fillWidth;
  final double? width;
  final bool outlinedButton;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      shape: WidgetStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      )),
      minimumSize: WidgetStateProperty.all<Size>(
        fillWidth
            ? const Size.fromHeight(45)
            : width != null
                ? Size(width!, 40)
                : const Size(5, 40),
      ),
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
      textStyle: WidgetStateProperty.all<TextStyle>(context.titleSmall!),
    );

    return outlinedButton
        ? OutlinedButton(
            key: key,
            onPressed: onTap,
            style: buttonStyle,
            child: child,
          )
        : ElevatedButton(
            key: key,
            onPressed: onTap,
            style: buttonStyle,
            child: child,
          );
  }
}

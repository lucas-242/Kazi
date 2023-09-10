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
  });
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool fillWidth;
  final bool outlinedButton;

  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      )),
      minimumSize: MaterialStateProperty.all<Size>(
        fillWidth ? const Size.fromHeight(45) : const Size(5, 40),
      ),
      backgroundColor: MaterialStateProperty.all<Color>(
        backgroundColor != null
            ? backgroundColor!
            : context.colorsScheme.onSurface,
      ),
      foregroundColor: MaterialStateProperty.all<Color>(
        foregroundColor != null
            ? foregroundColor!
            : context.colorsScheme.background,
      ),
      textStyle: MaterialStateProperty.all<TextStyle>(context.titleSmall!),
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

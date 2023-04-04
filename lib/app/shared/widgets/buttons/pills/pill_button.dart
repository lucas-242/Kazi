import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class PillButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget child;
  final Color? backgroundColor;
  final Color? foregroundColor;
  const PillButton({
    super.key,
    required this.onTap,
    required this.child,
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
          borderRadius: BorderRadius.circular(25),
        )),
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
      ),
      child: child,
    );
  }
}

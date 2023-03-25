import 'package:flutter/material.dart';
import 'package:my_services/app/shared/themes/themes.dart';

class CircularButton extends StatelessWidget {
  final VoidCallback onTap;
  final Widget child;
  const CircularButton({
    super.key,
    required this.onTap,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: IconButton(
        icon: child,
        onPressed: onTap,
        style: IconButton.styleFrom(
          foregroundColor: context.colorsScheme.surface,
          backgroundColor: context.colorsScheme.onSurface,
          disabledBackgroundColor:
              context.colorsScheme.onSurface.withOpacity(0.12),
          hoverColor: context.colorsScheme.onSurface.withOpacity(0.08),
          focusColor: context.colorsScheme.onSurface.withOpacity(0.12),
          highlightColor: context.colorsScheme.onSurface.withOpacity(0.12),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kazi/app/shared/themes/themes.dart';

class CircularButton extends StatelessWidget {

  const CircularButton({
    super.key,
    this.onTap,
    required this.child,
    this.iconSize,
    this.showCircularIndicator = false,
  });
  final VoidCallback? onTap;
  final Widget child;
  final double? iconSize;
  final bool showCircularIndicator;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(useMaterial3: true),
      child: Stack(
        children: [
          IconButton(
            icon: child,
            onPressed: onTap,
            iconSize: iconSize,
            style: IconButton.styleFrom(
              foregroundColor: context.colorsScheme.surface,
              backgroundColor: context.colorsScheme.onSurface,
              disabledBackgroundColor:
                  context.colorsScheme.onSurface.withValues(alpha: .12),
              hoverColor: context.colorsScheme.onSurface.withValues(alpha: .08),
              focusColor: context.colorsScheme.onSurface.withValues(alpha: .12),
              highlightColor:
                  context.colorsScheme.onSurface.withValues(alpha: .12),
            ),
          ),
          Visibility(
            visible: showCircularIndicator,
            child: Positioned(
              top: 4,
              left: 17,
              child: SizedBox(
                height: 15,
                child: CircleAvatar(
                  backgroundColor: context.colorsScheme.primary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

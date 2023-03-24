import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:my_services/app/shared/themes/extensions/theme_extension.dart';

class BottomNavigationButton extends StatelessWidget {
  final VoidCallback onTap;
  final String icon;
  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  const BottomNavigationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.padding = EdgeInsets.zero,
  });

  @override
  Widget build(BuildContext context) {
    Color color = isSelected
        ? context.colorsScheme.primary
        : context.colorsScheme.onPrimaryContainer;

    return Expanded(
      child: Padding(
        padding: padding,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
              const SizedBox(height: 5),
              Text(
                label,
                style: TextStyle(color: color),
              )
            ],
          ),
        ),
      ),
    );
  }
}

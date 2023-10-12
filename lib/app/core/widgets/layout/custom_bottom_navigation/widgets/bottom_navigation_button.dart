import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/core/themes/themes.dart';

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
    this.onboardingKey,
    this.onboardingTitle,
    this.onboardingDescription,
    this.onboardingCurrentPage,
    this.onboardingTooltipWidth,
    this.onboardingBackCallback,
    this.onboardingNextCallback,
  });

  final VoidCallback onTap;
  final String icon;
  final String label;
  final bool isSelected;
  final EdgeInsets padding;
  final GlobalKey? onboardingKey;
  final String? onboardingTitle;
  final String? onboardingDescription;
  final int? onboardingCurrentPage;
  final double? onboardingTooltipWidth;
  final VoidCallback? onboardingBackCallback;
  final VoidCallback? onboardingNextCallback;

  @override
  Widget build(BuildContext context) {
    final color = isSelected
        ? context.colorsScheme.primary
        : context.colorsScheme.onPrimaryContainer;

    final fontWeight = isSelected ? FontWeight.w500 : FontWeight.w400;

    return TextButton(
      onPressed: onTap,
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          key: onboardingKey,
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              icon,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            AppSizeConstants.tinyVerticalSpacer,
            Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 12,
                fontWeight: fontWeight,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

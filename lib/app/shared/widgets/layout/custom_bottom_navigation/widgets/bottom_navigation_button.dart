import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';

class BottomNavigationButton extends StatelessWidget {
  const BottomNavigationButton({
    super.key,
    required this.onTap,
    required this.icon,
    required this.label,
    required this.isSelected,
    this.padding = EdgeInsets.zero,
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

    List<Widget> getIconWithText() => [
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
        ];

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
              if (onboardingKey != null &&
                  onboardingTitle != null &&
                  onboardingDescription != null &&
                  onboardingCurrentPage != null)
                OnboardingTooltip(
                  onboardingKey: onboardingKey!,
                  title: onboardingTitle!,
                  description: onboardingDescription!,
                  currentPage: onboardingCurrentPage!,
                  position: OnboardingTooltipPosition.top,
                  width: onboardingTooltipWidth,
                  onNextCallback: onboardingNextCallback,
                  onBackCallback: onboardingBackCallback,
                  targetPadding: const EdgeInsets.only(
                    top: AppSizeConstants.mediumSpace,
                    bottom: AppSizeConstants.mediumSpace,
                    left: AppSizeConstants.largeSpace,
                    right: AppSizeConstants.largeSpace,
                  ),
                  child: Column(children: getIconWithText()),
                )
              else
                ...getIconWithText(),
            ],
          ),
        ),
      ),
    );
  }
}

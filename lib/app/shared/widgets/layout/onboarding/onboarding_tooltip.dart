import 'package:flutter/material.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/routes/app_router.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:showcaseview/showcaseview.dart';

enum OnboardingTooltipPosition {
  top,
  bottom,
  adaptative;

  TooltipPosition? toTooltipPosition() {
    switch (this) {
      case top:
        return TooltipPosition.top;
      case bottom:
        return TooltipPosition.bottom;
      case adaptative:
        return null;
    }
  }
}

class OnboardingTooltip extends StatelessWidget {
  const OnboardingTooltip({
    super.key,
    required this.onboardingKey,
    required this.title,
    required this.description,
    this.position = OnboardingTooltipPosition.adaptative,
    required this.currentPage,
    this.targetPadding = EdgeInsets.zero,
    this.onBackCallback,
    this.onNextCallback,
    this.width,
    required this.child,
  });

  final GlobalKey onboardingKey;
  final String title;
  final String description;
  final OnboardingTooltipPosition position;
  final int currentPage;
  final EdgeInsets targetPadding;
  final VoidCallback? onBackCallback;
  final VoidCallback? onNextCallback;
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    if (!AppRouter.showOnboarding) {
      return child;
    }

    return Showcase.withWidget(
      key: onboardingKey,
      height: 0,
      width: 300,
      overlayOpacity: 0.5,
      tooltipPosition: position.toTooltipPosition(),
      targetPadding: targetPadding,
      targetBorderRadius: const BorderRadius.all(Radius.circular(18)),
      container: Container(
        width: width ?? context.width * 0.918,
        decoration: const BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                top: AppSizeConstants.largeSpace,
                bottom: AppSizeConstants.smallSpace,
                left: AppSizeConstants.largeSpace,
                right: AppSizeConstants.largeSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(title, style: context.titleMedium),
                  Text(
                    '$currentPage of ${AppOnboarding.stepList.length}',
                    style: context.labelMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSizeConstants.largeSpace),
              child: Text(
                description,
                style: context.bodyMedium,
              ),
            ),
            AppSizeConstants.mediumVerticalSpacer,
            const Divider(
              color: AppColors.lightGrey,
              thickness: 0.9,
            ),
            AppSizeConstants.mediumVerticalSpacer,
            Padding(
              padding: const EdgeInsets.only(
                bottom: AppSizeConstants.mediumSpace,
                left: AppSizeConstants.largeSpace,
                right: AppSizeConstants.largeSpace,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Visibility(
                    visible: currentPage > 1,
                    child: CircularButton(
                      onTap: () {
                        ShowCaseWidget.of(context).previous();
                        if (onBackCallback != null) onBackCallback!();
                      },
                      child: const Icon(Icons.chevron_left),
                    ),
                  ),
                  PillButton(
                    onTap: () {
                      ShowCaseWidget.of(context).next();
                      if (onNextCallback != null) onNextCallback!();
                    },
                    child: Text(
                      currentPage == AppOnboarding.stepList.length
                          ? AppLocalizations.current.finish
                          : AppLocalizations.current.next,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      child: child,
    );
  }
}

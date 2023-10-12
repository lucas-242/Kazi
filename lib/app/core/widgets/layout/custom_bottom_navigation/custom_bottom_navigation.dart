import 'package:flutter/material.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/custom_bottom_navigation/widgets/bottom_navigation_button.dart';
import 'package:kazi/app/core/widgets/layout/custom_bottom_navigation/widgets/bottom_navigation_painter.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({
    Key? key,
    required this.currentPage,
    required this.onTap,
    required this.onTapFloatingButton,
  }) : super(key: key);
  final AppPages currentPage;
  final void Function(int) onTap;
  final VoidCallback onTapFloatingButton;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        CustomPaint(
          painter: BottomNavigationPainter(),
          size: Size(context.width, AppSizeConstants.bottomAppBarHeight),
        ),
        Center(
          heightFactor: 1.45,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 12),
            child: FloatingActionButton(
              onPressed: onTapFloatingButton,
              tooltip: AppLocalizations.current.newService,
              child: Icon(
                currentPage == AppPages.addServices ? Icons.close : Icons.add,
              ),
            ),
          ),
        ),
        SizedBox(
          width: context.width,
          height: AppSizeConstants.bottomAppBarHeight,
          child: Padding(
            padding: const EdgeInsets.only(top: AppSizeConstants.largeSpace),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                BottomNavigationButton(
                  onTap: () => onTap(AppPages.home.value),
                  icon: AppAssets.home,
                  label: 'Home',
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 24),
                  isSelected: currentPage == AppPages.home,
                ),
                AppSizeConstants.emptyWidget,
                BottomNavigationButton(
                  onTap: () => onTap(AppPages.services.value),
                  icon: AppAssets.services,
                  label: AppLocalizations.current.services.capitalize(),
                  isSelected: currentPage == AppPages.services,
                  onboardingKey: AppOnboarding.stepEight,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}

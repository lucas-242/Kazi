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
    required this.onTapFloatButton,
  }) : super(key: key);
  final AppPages currentPage;
  final void Function(int) onTap;
  final VoidCallback onTapFloatButton;

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
          child: FloatingActionButton(
            onPressed: onTapFloatButton,
            tooltip: AppLocalizations.current.newService,
            child: Icon(
              currentPage == AppPages.addServices ? Icons.close : Icons.add,
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
                  onTap: () => onTap(0),
                  icon: AppAssets.home,
                  label: 'Home',
                  isSelected: currentPage == AppPages.home,
                ),
                BottomNavigationButton(
                  onTap: () => onTap(1),
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

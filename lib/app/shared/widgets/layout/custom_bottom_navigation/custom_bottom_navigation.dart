import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/shared/constants/app_onboarding.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/layout/custom_bottom_navigation/widgets/bottom_navigation_button.dart';

class CustomBottomNavigation extends StatelessWidget {
  final int currentPage;
  final void Function(int) onTap;
  const CustomBottomNavigation({
    Key? key,
    this.currentPage = 0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          BottomNavigationButton(
            onTap: () => onTap(0),
            icon: AppAssets.home,
            label: 'Home',
            isSelected: currentPage == 0,
          ),
          BottomNavigationButton(
            onTap: () => onTap(1),
            icon: AppAssets.services,
            label: AppLocalizations.current.services.capitalize(),
            isSelected: currentPage == 1,
            // padding: const EdgeInsets.only(right: 32.0),
            onboardingKey: AppOnboarding.stepSix,
            onboardingTooltipWidth: context.width * 0.7,
            onboardingCurrentPage: 6,
            onboardingNextCallback: () {
              context.read<AppCubit>().changePage(1);
              context.go(AppRoutes.services);
            },
            onboardingTitle:
                AppLocalizations.current.tourBottomNavigationServicesTitle,
            onboardingDescription: AppLocalizations
                .current.tourBottomNavigationServicesDescription,
          ),
          // BottomNavigationButton(
          //   onTap: () => onTap(2),
          //   icon: AppAssets.calculator,
          //   label: AppLocalizations.current.calculator,
          //   isSelected: currentPage == 2,
          //   padding: const EdgeInsets.only(left: 32.0),
          // ),
          // BottomNavigationButton(
          //   onTap: () => onTap(3),
          //   icon: AppAssets.person,
          //   label: AppLocalizations.current.profile,
          //   isSelected: currentPage == 3,
          // ),
        ],
      ),
    );
  }
}

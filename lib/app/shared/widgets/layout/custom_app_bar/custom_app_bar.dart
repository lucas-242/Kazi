import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/constants/app_onboarding.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/layout/onboarding/onboarding_tooltip.dart';
import 'package:my_services/injector_container.dart';

class CustomAppBar extends StatelessWidget with PreferredSizeWidget {
  const CustomAppBar({
    Key? key,
    this.showOrderBy = false,
    this.onSelectedOrderBy,
  }) : super(key: key);

  final bool showOrderBy;
  final VoidCallback? onSelectedOrderBy;

  @override
  Size get preferredSize => const Size(0.0, 75.0);

  @override
  Widget build(BuildContext context) {
    final user = serviceLocator.get<AuthService>().user;

    void onTapImage() {
      context.read<AppCubit>().changePage(3);
      context.go(AppRoutes.profile);
    }

    return AppBar(
      toolbarHeight: preferredSize.height,
      centerTitle: true,
      automaticallyImplyLeading: false,
      foregroundColor: context.colorsScheme.onSurface,
      title: Row(
        children: [
          AppSizeConstants.smallHorizontalSpacer,
          OnboardingTooltip(
            onboardingKey: AppOnboarding.stepThree,
            title: AppLocalizations.current.onboardingAppBarTitle,
            currentPage: 3,
            description: AppLocalizations.current.onboardingAppBarDescription,
            child: TextButton(
              onPressed: onTapImage,
              child: SizedBox(
                width: 48.0,
                height: 48.0,
                child: CircleAvatar(
                  backgroundImage: user?.photoUrl != null
                      ? NetworkImage(user?.photoUrl ?? '')
                      : null,
                  backgroundColor: AppColors.white,
                  child: user?.photoUrl == null
                      ? Text(
                          '🦆',
                          style: context.cardTitle!.copyWith(fontSize: 38),
                        )
                      : null,
                ),
              ),
            ),
          ),
          AppSizeConstants.smallHorizontalSpacer,
          Text(
            user?.shortName ?? '',
            style: context.appBarTitle,
          ),
        ],
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(25),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: SvgPicture.asset(AppAssets.logo),
        ),
      ],
    );
  }
}

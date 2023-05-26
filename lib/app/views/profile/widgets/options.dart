import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/routes/app_router.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/views/profile/widgets/option_button.dart';

class Options extends StatelessWidget {
  const Options({super.key, required this.onSignOut});
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return OnboardingTooltip(
      onboardingKey: AppOnboarding.stepFour,
      title: AppLocalizations.current.tourProfileTitle,
      description: AppLocalizations.current.tourProfileDescription,
      currentPage: 4,
      onNextCallback: () {
        context.read<AppCubit>().changeToAddServicePage();
        context.go(AppRouter.addServiceType);
      },
      onBackCallback: () => context.go(AppRouter.home),
      targetPadding: const EdgeInsets.only(
        left: AppSizeConstants.mediumSpace,
        right: AppSizeConstants.mediumSpace,
      ),
      child: Column(
        children: [
          OptionButton(
            onTap: () => context.go(AppRouter.servicesType),
            text: AppLocalizations.current.serviceTypes,
          ),
          const Padding(
            padding:
                EdgeInsets.symmetric(horizontal: AppSizeConstants.largeSpace),
            child: Divider(),
          ),
          OptionButton(
            onTap: onSignOut,
            text: AppLocalizations.current.logout,
            textStyle: context.titleSmall!.copyWith(color: AppColors.red),
          ),
        ],
      ),
    );
  }
}

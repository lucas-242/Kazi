import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/shared/constants/app_onboarding.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/onboarding/onboarding_tooltip.dart';
import 'package:my_services/app/views/home/home.dart';
import 'package:my_services/app/views/services/services.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  final HomeState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OnboardingTooltip(
            onboardingKey: AppOnboarding.stepOne,
            title: AppLocalizations.current.onboardingHomeBalanceTitle,
            description:
                AppLocalizations.current.onboardingHomeBalanceDescription,
            currentPage: 1,
            targetPadding: const EdgeInsets.only(
              top: AppSizeConstants.largeSpace,
              bottom: AppSizeConstants.mediumSpace,
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
            ),
            child: Column(
              children: [
                InfoCard(
                  title: NumberFormatHelper.formatCurrency(
                      context, state.totalWithDiscount),
                  subtitle: context.appLocalizations.myBalance,
                  icon: AppAssets.services,
                  color: AppColors.green,
                ),
                InfoCard(
                  title: NumberFormatHelper.formatCurrency(
                      context, state.totalDiscounted),
                  subtitle: context.appLocalizations.discounts,
                  icon: AppAssets.fire,
                  color: AppColors.orange,
                ),
                InfoCard(
                  title: NumberFormatHelper.formatCurrency(
                      context, state.totalValue),
                  subtitle: context.appLocalizations.totalReceived,
                  icon: AppAssets.rocket,
                  color: AppColors.blue,
                ),
              ],
            ),
          ),
          AppSizeConstants.smallVerticalSpacer,
          TitleAndPill(
            title: context.appLocalizations.lastServices,
            pillText: context.appLocalizations.newService,
            onTap: () {
              context.read<AppCubit>().changeToAddServicePage();
              context.go(AppRoutes.addServices);
            },
          ),
          AppSizeConstants.largeVerticalSpacer,
          OnboardingTooltip(
            onboardingKey: AppOnboarding.stepTwo,
            title: AppLocalizations.current.onboardingHomeServicesTitle,
            description:
                AppLocalizations.current.onboardingHomeServicesDescription,
            position: OnboardingTooltipPosition.top,
            currentPage: 2,
            targetPadding: const EdgeInsets.only(
              top: AppSizeConstants.largeSpace,
              bottom: AppSizeConstants.mediumSpace,
              left: AppSizeConstants.largeSpace,
              right: AppSizeConstants.largeSpace,
            ),
            child: SizedBox(
              height: 245,
              child: ServiceList(
                services: state.services,
                expandList: true,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

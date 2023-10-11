import 'package:flutter/material.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/number_format_utils.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/features/home/home.dart';
import 'package:kazi/app/features/services/services.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.state,
    this.isOnboarding = false,
  });

  final HomeState state;
  final bool isOnboarding;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoCard(
            key: isOnboarding ? AppOnboarding.stepOne : null,
            title:
                NumberFormatUtils.formatCurrency(context, state.totalBalance),
            subtitle: AppLocalizations.current.myBalance,
            icon: AppAssets.services,
            color: AppColors.green,
          ),
          InfoCard(
            key: isOnboarding ? AppOnboarding.stepTwo : null,
            title: NumberFormatUtils.formatCurrency(
                context, state.totalDiscounted),
            subtitle: AppLocalizations.current.discounts,
            icon: AppAssets.fire,
            color: AppColors.orange,
          ),
          InfoCard(
            key: isOnboarding ? AppOnboarding.stepThree : null,
            title: NumberFormatUtils.formatCurrency(context, state.totalValue),
            subtitle: AppLocalizations.current.totalReceived,
            icon: AppAssets.rocket,
            color: AppColors.blue,
          ),
          AppSizeConstants.smallVerticalSpacer,
          TitleAndPill(
            title: AppLocalizations.current.lastServices,
            pillText: AppLocalizations.current.newService,
            onTap: () => context.navigateToAddServices(),
          ),
          AppSizeConstants.largeVerticalSpacer,
          SizedBox(
            key: isOnboarding ? AppOnboarding.stepFour : null,
            height: 245,
            child: ServiceList(
              services: state.services,
              expandList: true,
              canScroll: true,
            ),
          ),
        ],
      ),
    );
  }
}

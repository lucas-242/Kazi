import 'package:flutter/material.dart';
import 'package:kazi/presenter/home/home.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/number_format_utils.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class HomeContent extends StatelessWidget {
  const HomeContent({
    super.key,
    required this.state,
    this.showOnboarding = false,
  });

  final HomeState state;
  final bool showOnboarding;

  @override
  Widget build(BuildContext context) {
    return KaziSingleScrollView(
      children: [
        Text(
          AppLocalizations.current.yourEarnings,
          style: context.titleMedium,
        ),
        KaziSpacings.verticalLg,
        InfoCard(
          key: showOnboarding ? AppOnboarding.stepOne : null,
          title: NumberFormatUtils.formatCurrency(context, state.totalBalance),
          subtitle: AppLocalizations.current.myBalance,
          icon: KaziAssets.services,
          color: KaziColors.green,
        ),
        InfoCard(
          key: showOnboarding ? AppOnboarding.stepTwo : null,
          title:
              NumberFormatUtils.formatCurrency(context, state.totalDiscounted),
          subtitle: AppLocalizations.current.discounts,
          icon: KaziAssets.fire,
          color: KaziColors.orange,
        ),
        InfoCard(
          key: showOnboarding ? AppOnboarding.stepThree : null,
          title: NumberFormatUtils.formatCurrency(context, state.totalValue),
          subtitle: AppLocalizations.current.totalReceived,
          icon: KaziAssets.rocket,
          color: KaziColors.blue,
        ),
        KaziSpacings.verticalSm,
        KaziTitleAndPill(
          title: AppLocalizations.current.lastServices,
          pillText: AppLocalizations.current.newService,
          onTap: () => context.navigateToAddServices(),
        ),
        KaziSpacings.verticalLg,
        SizedBox(
          key: showOnboarding ? AppOnboarding.stepFour : null,
          height: 200,
          child: ServiceList(
            services: state.services,
            expandList: true,
            canScroll: true,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:kazi/app/core/constants/app_onboarding.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/number_format_helper.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/features/home/home.dart';
import 'package:kazi/app/features/services/services.dart';

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
          InfoCard(
            key: AppOnboarding.stepOne,
            title:
                NumberFormatHelper.formatCurrency(context, state.totalBalance),
            subtitle: AppLocalizations.current.myBalance,
            icon: AppAssets.services,
            color: AppColors.green,
          ),
          InfoCard(
            key: AppOnboarding.stepTwo,
            title: NumberFormatHelper.formatCurrency(
                context, state.totalDiscounted),
            subtitle: AppLocalizations.current.discounts,
            icon: AppAssets.fire,
            color: AppColors.orange,
          ),
          InfoCard(
            key: AppOnboarding.stepThree,
            title: NumberFormatHelper.formatCurrency(context, state.totalValue),
            subtitle: AppLocalizations.current.totalReceived,
            icon: AppAssets.rocket,
            color: AppColors.blue,
          ),
          AppSizeConstants.smallVerticalSpacer,
          TitleAndPill(
            title: AppLocalizations.current.lastServices,
            pillText: AppLocalizations.current.newService,
            onTap: () => context.navigateTo(AppPage.addServices),
          ),
          AppSizeConstants.largeVerticalSpacer,
          SizedBox(
            key: AppOnboarding.stepFour,
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

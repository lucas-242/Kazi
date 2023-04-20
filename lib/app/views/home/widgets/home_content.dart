import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/views/home/home.dart';
import 'package:my_services/app/views/home/widgets/info_card.dart';

import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/buttons/pills/title_and_pill.dart';
import 'package:my_services/app/views/services/services.dart';

class HomeContent extends StatelessWidget {
  final HomeState state;
  const HomeContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InfoCard(
          title: NumberFormatHelper.formatCurrency(context, state.totalValue),
          subtitle: AppLocalizations.current.myBalance,
          icon: AppAssets.services,
          color: AppColors.green,
        ),
        InfoCard(
          title:
              NumberFormatHelper.formatCurrency(context, state.totalDiscounted),
          subtitle: AppLocalizations.current.discounts,
          icon: AppAssets.fire,
          color: AppColors.orange,
        ),
        InfoCard(
          title: NumberFormatHelper.formatCurrency(
              context, state.totalWithDiscount),
          subtitle: AppLocalizations.current.totalReceived,
          icon: AppAssets.rocket,
          color: AppColors.blue,
        ),
        AppSizeConstants.smallVerticalSpacer,
        TitleAndPill(
          title: AppLocalizations.current.lastServices,
          pillText: AppLocalizations.current.newService,
          onTap: () {
            context.read<AppCubit>().changeToAddServicePage();
            context.go(AppRoutes.addServices);
          },
        ),
        AppSizeConstants.largeVerticalSpacer,
        Expanded(child: ServiceList(services: state.services)),
      ],
    );
  }
}
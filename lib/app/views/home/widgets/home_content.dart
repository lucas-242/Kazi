import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/views/home/widgets/info_card.dart';

import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/utils/number_format_helper.dart';
import 'package:my_services/app/shared/widgets/service_list/service_list.dart';
import 'package:my_services/app/shared/widgets/buttons/pills/title_and_pill.dart';
import 'package:my_services/app/views/services/add_services/cubit/add_services_cubit.dart';
import 'package:my_services/app/views/calendar/cubit/calendar_cubit.dart';
import '../cubit/home_cubit.dart';

class HomeContent extends StatelessWidget {
  final HomeState state;
  const HomeContent({
    Key? key,
    required this.state,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void onDelete(Service service) async {
      final calendarCubit = context.read<CalendarCubit>();
      await context.read<HomeCubit>().deleteService(service);
      calendarCubit.onChangeServices();
    }

    void onEdit(Service service) async {
      context.read<AddServicesCubit>().onChangeService(service);
      context.go(AppRoutes.addServices);
    }

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
        const SizedBox(height: 10),
        TitleAndPill(
          title: AppLocalizations.current.lastServices,
          pillText: AppLocalizations.current.newService,
          onTap: () => context.go(AppRoutes.addServices),
        ),
        const SizedBox(height: 20),
        ServiceList(services: state.services),
      ],
    );
  }
}

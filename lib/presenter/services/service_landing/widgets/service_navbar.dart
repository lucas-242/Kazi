import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/core/components/texts/texts.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceNavbar extends StatelessWidget {
  const ServiceNavbar({
    super.key,
    required this.dateController,
  });

  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    final serviceCubit = context.read<ServiceLandingCubit>();

    return TextWithTrailing(
      text: AppLocalizations.current.services,
      trailing: Row(
        children: [
          KaziCircularButton(
            onTap: () => showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (context) => OrderByBottomSheet(
                selectedOption: serviceCubit.state.selectedOrderBy,
                onPressed: (orderBy) {
                  context.navigateBack();
                  serviceCubit.onChangeOrderBy(orderBy);
                },
              ),
            ),
            child: const Icon(
              Icons.swap_vert,
              size: 18,
            ),
          ),
          KaziSpacings.horizontalSm,
          KaziCircularButton(
            showCircularIndicator: serviceCubit.state.didFiltersChange,
            onTap: () => showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (context) =>
                  FiltersBottomSheet(dateController: dateController),
            ),
            child: const Icon(Icons.filter_list_alt, size: 18),
          ),
          KaziSpacings.horizontalSm,
          KaziPillButton(
            onTap: () => context.navigateToAddServices(),
            child: Text(AppLocalizations.current.newService),
          )
        ],
      ),
    );
  }
}

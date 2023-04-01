import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/texts/texts.dart';
import 'package:my_services/app/views/services/services.dart';

class TitleWithButtons extends StatelessWidget {
  final bool showFilters;
  final Widget? filtersBottomSheet;

  const TitleWithButtons({
    super.key,
    this.showFilters = true,
    this.filtersBottomSheet,
  });

  @override
  Widget build(BuildContext context) {
    final serviceCubit = context.read<ServiceLandingCubit>();

    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSizeConstants.smallSpace),
      child: TextWithTrailing(
        text: AppLocalizations.current.services,
        trailing: Row(
          children: [
            Visibility(
              visible: showFilters,
              child: CircularButton(
                onTap: () => showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (context) => OrderByBottomSheet(
                    selectedOption: serviceCubit.state.selectedOrderBy,
                    onPressed: (orderBy) {
                      context.pop();
                      serviceCubit.onChangeOrderBy(orderBy);
                    },
                  ),
                ),
                child: const Icon(
                  Icons.swap_vert,
                  size: 18,
                ),
              ),
            ),
            AppSizeConstants.smallHorizontalSpacer,
            Visibility(
              visible: showFilters,
              child: CircularButton(
                showCircularIndicator: serviceCubit.state.didFiltersChange,
                onTap: () => showModalBottomSheet(
                  context: context,
                  useRootNavigator: true,
                  isScrollControlled: true,
                  builder: (context) => filtersBottomSheet!,
                ),
                child: const Icon(
                  Icons.filter_list_alt,
                  size: 18,
                ),
              ),
            ),
            AppSizeConstants.smallHorizontalSpacer,
            PillButton(
              onTap: () {
                context.read<AppCubit>().changeToAddServicePage();
                context.go(AppRoutes.addServices);
              },
              child: Text(AppLocalizations.current.newService),
            )
          ],
        ),
      ),
    );
  }
}

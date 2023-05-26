import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/routes/app_router.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:kazi/app/shared/widgets/texts/texts.dart';
import 'package:kazi/app/views/services/services.dart';

class ServiceNavbar extends StatelessWidget {
  const ServiceNavbar({
    super.key,
    required this.dateKey,
    required this.dateController,
  });

  final GlobalKey<FormFieldState<dynamic>> dateKey;
  final TextEditingController dateController;

  @override
  Widget build(BuildContext context) {
    final serviceCubit = context.read<ServiceLandingCubit>();

    return TextWithTrailing(
      text: AppLocalizations.current.services,
      trailing: Row(
        children: [
          CircularButton(
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
          AppSizeConstants.smallHorizontalSpacer,
          CircularButton(
            showCircularIndicator: serviceCubit.state.didFiltersChange,
            onTap: () => showModalBottomSheet(
              context: context,
              useRootNavigator: true,
              isScrollControlled: true,
              builder: (context) => FiltersBottomSheet(
                dateKey: dateKey,
                dateController: dateController,
              ),
            ),
            child: const Icon(
              Icons.filter_list_alt,
              size: 18,
            ),
          ),
          AppSizeConstants.smallHorizontalSpacer,
          PillButton(
            onTap: () {
              context.read<AppCubit>().changeToAddServicePage();
              context.go(AppRouter.addServices);
            },
            child: Text(AppLocalizations.current.newService),
          )
        ],
      ),
    );
  }
}

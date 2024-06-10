import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/services/service_types/widgets/service_type_no_data_navbar.dart';
import 'package:kazi/app/features/services/service_types/widgets/service_types_content.dart';

import '../service_types.dart';

class ServiceTypesPage extends StatefulWidget {
  const ServiceTypesPage({super.key});

  @override
  State<ServiceTypesPage> createState() => _ServiceTypesPageState();
}

class _ServiceTypesPageState extends State<ServiceTypesPage> {
  @override
  void initState() {
    context.read<ServiceTypesCubit>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      onRefresh: () => context.read<ServiceTypesCubit>().getServiceTypes(),
      child: BlocConsumer<ServiceTypesCubit, ServiceTypesState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            context.showSnackBar(state.callbackMessage);
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.when(
            onState: (_) => const ServiceTypesContent(),
            onLoading: () => const Loading(),
            onNoData: () => NoData(
              message: AppLocalizations.current.noServiceTypes,
              navbar: const ServiceTypeNoDataNavbar(),
            ),
          );
        },
      ),
    );
  }
}

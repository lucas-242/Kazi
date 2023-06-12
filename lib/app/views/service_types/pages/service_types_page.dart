import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/views/service_types/widgets/service_type_no_data_navbar.dart';
import 'package:kazi/app/views/service_types/widgets/service_types_content.dart';

import '../service_types.dart';

class ServiceTypesPage extends StatelessWidget {
  const ServiceTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceTypesCubit>().onInit();

    return CustomSafeArea(
      onRefresh: () => context.read<ServiceTypesCubit>().getServiceTypes(),
      child: BlocListener<ServiceTypesCubit, ServiceTypesState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            getCustomSnackBar(
              context,
              message: state.callbackMessage,
            );
          }
        },
        child: BlocBuilder<ServiceTypesCubit, ServiceTypesState>(
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
      ),
    );
  }
}

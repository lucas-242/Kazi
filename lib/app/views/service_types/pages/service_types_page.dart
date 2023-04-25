import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/service_types/widgets/service_type_no_data_navbar.dart';
import 'package:my_services/app/views/service_types/widgets/service_types_content.dart';

import '../service_types.dart';

class ServiceTypesPage extends StatelessWidget {
  const ServiceTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<ServiceTypesCubit>().onInit();

    return CustomScaffold(
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
                message: context.appLocalizations.noServiceTypes,
                navbar: const ServiceTypeNoDataNavbar(),
              ),
            );
          },
        ),
      ),
    );
  }
}

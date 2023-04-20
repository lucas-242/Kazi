import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/repositories/service_type_repository/service_type_repository.dart';
import 'package:my_services/app/repositories/services_repository/services_repository.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/shared/widgets/layout/loading/loading.dart';
import 'package:my_services/app/views/service_types/widgets/service_types_content.dart';
import 'package:my_services/injector_container.dart';

import '../service_types.dart';

class ServiceTypesPage extends StatelessWidget {
  const ServiceTypesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ServiceTypesCubit>(
      create: (context) => ServiceTypesCubit(
        serviceLocator.get<ServiceTypeRepository>(),
        serviceLocator.get<ServicesRepository>(),
        serviceLocator.get<AuthService>(),
      ),
      lazy: false,
      child: Builder(builder: (context) {
        context.read<ServiceTypesCubit>().onInit();

        return CustomScaffold(
          onRefresh: () => context.read<ServiceTypesCubit>().getServiceTypes(),
          child: BlocListener<ServiceTypesCubit, ServiceTypesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == BaseStateStatus.error) {
                getCustomSnackBar(
                  context,
                  message: state.callbackMessage,
                );
              }
            },
            child: BlocBuilder<ServiceTypesCubit, ServiceTypesState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return state.when(
                  onState: (_) => const ServiceTypesContent(),
                  onLoading: () => const Loading(),
                  //TODO: Create new layout for NoData widget
                  onNoData: () => const _NoData(),
                );
              },
            ),
          ),
        );
      }),
    );
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypesCubit>();

    return Column(
      children: [
        Text(AppLocalizations.current.noServiceTypes,
            style: context.headlineSmall),
        AppSizeConstants.bigVerticalSpacer,
        CustomElevatedButton(
          onTap: () => context.go(
            AppRoutes.addServiceType,
            extra: cubit,
          ),
          text: AppLocalizations.current.newServiceType,
        ),
      ],
    );
  }
}

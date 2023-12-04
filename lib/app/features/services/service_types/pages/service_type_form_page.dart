import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

import '../service_types.dart';

class ServiceTypeFormPage extends StatefulWidget {
  const ServiceTypeFormPage({super.key});

  @override
  State<ServiceTypeFormPage> createState() => _ServiceTypeFormPageState();
}

class _ServiceTypeFormPageState extends State<ServiceTypeFormPage> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypesCubit>();

    void onConfirm() {
      if (cubit.state.serviceType.id == 0) {
        cubit.addServiceType();
      } else {
        cubit.updateServiceType();
      }
    }

    void onTapBack() {
      cubit.eraseServiceType();
      context.navigateBack();
    }

    return BlocProvider.value(
      value: cubit,
      child: PopScope(
        onPopInvoked: (_) => cubit.eraseServiceType(),
        child: CustomSafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              cubit.state.serviceType.id == 0
                  ? BackAndPill(
                      text: AppLocalizations.current.newServiceType,
                      onTapBack: onTapBack,
                    )
                  : BackAndPill(
                      text: AppLocalizations.current.editServiceType,
                      pillText: AppLocalizations.current.delete,
                      backgroundColor: context.colorsScheme.error,
                      onTapBack: onTapBack,
                      onTapPill: () =>
                          cubit.deleteServiceType(cubit.state.serviceType),
                    ),
              AppSizeConstants.bigVerticalSpacer,
              BlocConsumer<ServiceTypesCubit, ServiceTypesState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == BaseStateStatus.success) {
                    context.navigateBack();
                  }
                },
                builder: (context, state) => state.when(
                  onState: (_) => ServiceTypeFormContent(
                    onConfirm: onConfirm,
                  ),
                  onLoading: () => const Loading(expanded: true),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

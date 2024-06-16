import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/presenter/services/service_form/widgets/service_form_content.dart';
import 'package:kazi/presenter/services/service_types/widgets/service_type_no_data_navbar.dart';
import 'package:kazi/presenter/services/services.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:kazi_design_system/kazi_design_system.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({
    super.key,
    this.service,
  });

  final Service? service;

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  bool isCreating(Service? service) =>
      service == null || service.id == 0 ? true : false;

  @override
  void initState() {
    context.read<ServiceFormCubit>().onInit(widget.service);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_) => context.navigateToAddServices(),
      child: KaziSafeArea(
        child: BlocConsumer<ServiceFormCubit, ServiceFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BaseStateStatus.success) {
              context
                  .read<ServiceLandingCubit>()
                  .onChangeServices(state.newServices);
              context.showSnackBar(
                state.callbackMessage,
                type: SnackBarType.success,
              );
              context.navigateToAddServices();
            } else if (state.status == BaseStateStatus.error) {
              context.showSnackBar(state.callbackMessage);
            }
          },
          builder: (context, state) {
            return state.when(
              onState: (_) {
                return ServiceFormContent(
                  isCreating: isCreating(widget.service),
                  onConfirm: () => onConfirm(state.service),
                  showOnboarding: context.showOnboarding,
                );
              },
              onLoading: () => const KaziLoading(),
              onNoData: () => KaziNoData(
                message: AppLocalizations.current.noServiceTypes,
                navbar: const ServiceTypeNoDataNavbar(),
              ),
            );
          },
        ),
      ),
    );
  }

  void onConfirm(Service service) {
    if (isCreating(service)) {
      context.read<ServiceFormCubit>().addService();
    } else {
      context.read<ServiceFormCubit>().updateService();
    }
  }
}

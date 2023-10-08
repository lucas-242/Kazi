import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/services/service_form/widgets/service_form_content.dart';
import 'package:kazi/app/features/services/service_types/widgets/service_type_no_data_navbar.dart';
import 'package:kazi/app/features/services/services.dart';
import 'package:kazi/app/models/service.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key, this.service, this.lastPage});

  final Service? service;
  final AppPages? lastPage;

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
    return WillPopScope(
      onWillPop: () async {
        context.floatingActionNavigation(widget.lastPage);
        return false;
      },
      child: CustomSafeArea(
        child: BlocConsumer<ServiceFormCubit, ServiceFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BaseStateStatus.success) {
              context
                  .read<ServiceLandingCubit>()
                  .onChangeServices(state.newServices);
              getCustomSnackBar(
                context,
                message: state.callbackMessage,
                type: SnackBarType.success,
              );
              context.floatingActionNavigation(widget.lastPage);
            } else if (state.status == BaseStateStatus.error) {
              getCustomSnackBar(
                context,
                message: state.callbackMessage,
              );
            }
          },
          builder: (context, state) {
            return state.when(
              onState: (_) {
                return ServiceFormContent(
                  isCreating: isCreating(widget.service),
                  onConfirm: () => onConfirm(state.service),
                );
              },
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

  void onConfirm(Service service) {
    if (isCreating(service)) {
      context.read<ServiceFormCubit>().addService();
    } else {
      context.read<ServiceFormCubit>().updateService();
    }
  }
}

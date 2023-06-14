import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/models/service.dart';
import 'package:kazi/app/shared/extensions/extensions.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/utils/base_state.dart';
import 'package:kazi/app/shared/widgets/layout/layout.dart';
import 'package:kazi/app/views/service_types/widgets/service_type_no_data_navbar.dart';
import 'package:kazi/app/views/services/service_form/widgets/service_form_content.dart';
import 'package:kazi/app/views/services/services.dart';

class ServiceFormPage extends StatefulWidget {
  const ServiceFormPage({super.key, this.service});

  final Service? service;

  @override
  State<ServiceFormPage> createState() => _ServiceFormPageState();
}

class _ServiceFormPageState extends State<ServiceFormPage> {
  bool isCreating(Service? service) => service?.id.isEmpty ?? true;

  @override
  void initState() {
    context.read<ServiceFormCubit>().onInit(widget.service);
    super.initState();
  }

  void onConfirm(Service service) {
    if (isCreating(service)) {
      context.read<ServiceFormCubit>().addService();
    } else {
      context.read<ServiceFormCubit>().updateService();
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: SingleChildScrollView(
        child: BlocListener<ServiceFormCubit, ServiceFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BaseStateStatus.success) {
              context.read<ServiceLandingCubit>().onChangeServices();
              context.back();
            } else if (state.status == BaseStateStatus.error) {
              getCustomSnackBar(
                context,
                message: state.callbackMessage,
              );
            }
          },
          child: BlocBuilder<ServiceFormCubit, ServiceFormState>(
            builder: (context, state) {
              return state.when(
                onState: (_) {
                  if (state.status == BaseStateStatus.readyToUserInput) {
                    return ServiceFormContent(
                      isCreating: isCreating(widget.service),
                      onConfirm: () => onConfirm(state.service),
                    );
                  }

                  return const Loading();
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
      ),
    );
  }
}

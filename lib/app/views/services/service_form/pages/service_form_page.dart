import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/shared/widgets/layout/loading/loading.dart';
import 'package:my_services/app/views/services/service_form/widgets/service_form_content.dart';
import 'package:my_services/app/views/services/services.dart';

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
    return CustomScaffold(
      child: SingleChildScrollView(
        child: BlocListener<ServiceFormCubit, ServiceFormState>(
          listenWhen: (previous, current) => previous.status != current.status,
          listener: (context, state) {
            if (state.status == BaseStateStatus.success) {
              //TODO: Remove onChangeServices
              context.read<ServiceLandingCubit>().onChangeServices();
              context.pop();
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
                onNoData: () => const _NoData(),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          AppLocalizations.current.noServiceTypes,
          style: context.titleMedium,
          textAlign: TextAlign.center,
        ),
        AppSizeConstants.bigVerticalSpacer,
        CustomElevatedButton(
          onTap: () {
            context.pop();
            context.read<AppCubit>().changePage(2);
          },
          text: AppLocalizations.current.newType,
        ),
      ],
    );
  }
}

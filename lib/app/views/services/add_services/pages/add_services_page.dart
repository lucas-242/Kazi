import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/app_cubit.dart';
import 'package:my_services/app/models/service.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/home/cubit/home_cubit.dart';

import 'package:my_services/app/views/services/add_services/widgets/add_services_form.dart';
import 'package:my_services/app/views/services/services.dart';

class AddServicesPage extends StatefulWidget {
  const AddServicesPage({super.key});

  @override
  State<AddServicesPage> createState() => _AddServicesPageState();
}

class _AddServicesPageState extends State<AddServicesPage> {
  @override
  void initState() {
    context.read<AddServicesCubit>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<AddServicesCubit, AddServicesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == BaseStateStatus.success) {
                context.read<HomeCubit>().onChangeServices();
                context.read<ServiceLandingCubit>().onChangeServices();
                context.pop();
              } else if (state.status == BaseStateStatus.error) {
                getCustomSnackBar(
                  context,
                  message: state.callbackMessage,
                );
              }
            },
            child: BlocBuilder<AddServicesCubit, AddServicesState>(
              builder: (context, state) {
                return state.when(
                  onState: (_) => _Build(service: state.service),
                  onLoading: () => SizedBox(
                    height: context.height,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  onNoData: () => const _NoData(),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

class _Build extends StatelessWidget {
  final Service service;
  const _Build({required this.service});

  @override
  Widget build(BuildContext context) {
    final label = service.id != ''
        ? AppLocalizations.current.update
        : AppLocalizations.current.add;

    void onConfirm() {
      if (service.id.isEmpty) {
        context.read<AddServicesCubit>().addService();
      } else {
        context.read<AddServicesCubit>().updateService();
      }
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 25),
        AddServicesForm(
          labelButton: label,
          onConfirm: () => onConfirm(),
        ),
      ],
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
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () {
            context.pop();
            context.read<AppCubit>().changePage(2);
          },
          text: AppLocalizations.current.addNewServiceType,
        ),
      ],
    );
  }
}

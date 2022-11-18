import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/models/base_state.dart';
import 'package:my_services/views/home/cubit/home_cubit.dart';

import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';
import '../cubit/add_services_cubit.dart';
import '../widgets/add_services_form.dart';

class AddServicesPage extends StatefulWidget {
  const AddServicesPage({super.key});

  @override
  State<AddServicesPage> createState() => _AddServicesPageState();
}

class _AddServicesPageState extends State<AddServicesPage> {
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
                final serviceList =
                    context.read<AddServicesCubit>().serviceProvidedList;
                context
                    .read<HomeCubit>()
                    .changeServiceProvidedList(serviceList);
                Navigator.of(context).pop();
              }
              if (state.status == BaseStateStatus.error) {
                getCustomSnackBar(
                  context,
                  message: state.callbackMessage,
                  type: SnackBarType.error,
                );
              }
            },
            child: BlocBuilder<AddServicesCubit, AddServicesState>(
              buildWhen: (previous, current) =>
                  previous.status != current.status,
              builder: (context, state) {
                return state.when(
                  onState: (_) =>
                      _Build(serviceProvided: state.serviceProvided),
                  onLoading: () => SizedBox(
                    height: context.height,
                    child: const Center(child: CircularProgressIndicator()),
                  ),
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
  final ServiceProvided serviceProvided;
  const _Build({required this.serviceProvided});

  @override
  Widget build(BuildContext context) {
    final label = serviceProvided.id != '' ? 'Editar' : 'Adicionar';
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Visibility(
            visible: serviceProvided.id != '',
            child: Text('$label tipo de serviço', style: context.headlineSmall),
          ),
          Visibility(
            visible: serviceProvided.id == '',
            child: Text('$label tipo de serviço', style: context.headlineSmall),
          ),
          const SizedBox(height: 25),
          AddServicesForm(
            labelButton: label,
            onConfirm: () => serviceProvided.id == ''
                ? context.read<AddServicesCubit>().addServiceProvided()
                : context.read<AddServicesCubit>().updateServiceProvided(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/models/service_provided.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/models/base_state.dart';
import 'package:my_services/shared/widgets/custom_app_bar/custom_app_bar_widget.dart';
import 'package:my_services/views/app/app.dart';
import 'package:my_services/views/calendar/calendar.dart';
import 'package:my_services/views/home/cubit/home_cubit.dart';

import '../../../shared/widgets/custom_elevated_button/custom_elevated_button.dart';
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
  void initState() {
    context.read<AddServicesCubit>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final label = context.read<AddServicesCubit>().state.service.id != ''
        ? 'Editar'
        : 'Adicionar';
    return Scaffold(
      appBar: CustomAppBar(
        title: '$label tipo de serviço',
        leading: const BackButton(),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BlocListener<AddServicesCubit, AddServicesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == BaseStateStatus.success) {
                context.read<HomeCubit>().changeServices();
                context.read<CalendarCubit>().changeServices();
                Navigator.of(context).pop();
              } else if (state.status == BaseStateStatus.error) {
                getCustomSnackBar(
                  context,
                  message: state.callbackMessage,
                  type: SnackBarType.error,
                );
              }
            },
            child: BlocBuilder<AddServicesCubit, AddServicesState>(
              builder: (context, state) {
                return state.when(
                  onState: (_) => _Build(serviceProvided: state.service),
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
  final ServiceProvided serviceProvided;
  const _Build({required this.serviceProvided});

  @override
  Widget build(BuildContext context) {
    final label = serviceProvided.id != '' ? 'Editar' : 'Adicionar';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const SizedBox(height: 25),
        AddServicesForm(
          labelButton: label,
          onConfirm: () => serviceProvided.id == ''
              ? context.read<AddServicesCubit>().addServiceProvided()
              : context.read<AddServicesCubit>().updateServiceProvided(),
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
          'Não há tipos de serviço cadastrado',
          style: context.titleMedium,
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () {
            Navigator.of(context).pop();
            context.read<AppCubit>().changePage(2);
          },
          text: 'Adicionar novo tipo de serviço',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/widgets/base_state/base_state.dart';
import 'package:my_services/views/home/cubit/home_cubit.dart';
import 'package:my_services/views/home/widgets/add_service_provided_form.dart';

import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';

class AddServiceProvidedPage extends StatefulWidget {
  const AddServiceProvidedPage({super.key});

  @override
  State<AddServiceProvidedPage> createState() => _AddServiceProvidedPageState();
}

class _AddServiceProvidedPageState extends State<AddServiceProvidedPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context.read<HomeCubit>().eraseServiceProvided();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<HomeCubit, HomeState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == BaseStateStatus.success) {
                Navigator.of(context).pop();
              } else if (state.status == BaseStateStatus.error) {
                getCustomSnackBar(
                  context,
                  message: state.callbackMessage,
                  type: SnackBarType.error,
                );
              }
            },
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                final label =
                    state.serviceProvided.id != '' ? 'Editar' : 'Adicionar';
                return Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: Column(
                    children: [
                      Visibility(
                        visible: state.serviceProvided.id != '',
                        child: Text('$label tipo de serviço',
                            style: context.headlineSmall),
                      ),
                      Visibility(
                        visible: state.serviceProvided.id == '',
                        child: Text('$label tipo de serviço',
                            style: context.headlineSmall),
                      ),
                      const SizedBox(height: 25),
                      AddServiceProvidedForm(
                        labelButton: label,
                        onConfirm: () => state.serviceProvided.id == ''
                            ? context.read<HomeCubit>().addServiceProvided()
                            : context.read<HomeCubit>().updateServiceProvided(),
                      ),
                    ],
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

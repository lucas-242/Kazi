import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/widgets/base_state/base_state.dart';
import 'package:my_services/views/settings/settings.dart';

import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';

class AddServiceTypePage extends StatefulWidget {
  const AddServiceTypePage({super.key});

  @override
  State<AddServiceTypePage> createState() => _AddServiceTypePageState();
}

class _AddServiceTypePageState extends State<AddServiceTypePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<SettingsCubit, SettingsState>(
          listenWhen: (previous, current) => previous.status != current.status,
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
          child: Padding(
            padding: const EdgeInsets.only(top: 25),
            child: Column(
              children: [
                Text('Adicionar tipo de serviço', style: context.headlineSmall),
                const SizedBox(height: 25),
                const AddServiceTypeForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

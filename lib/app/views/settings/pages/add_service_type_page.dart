import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/widgets/custom_app_bar/custom_app_bar.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import '../settings.dart';

class AddServiceTypePage extends StatefulWidget {
  const AddServiceTypePage({super.key});

  @override
  State<AddServiceTypePage> createState() => _AddServiceTypePageState();
}

class _AddServiceTypePageState extends State<AddServiceTypePage> {
  @override
  Widget build(BuildContext context) {
    final label = context.read<SettingsCubit>().state.serviceType.id != ''
        ? AppLocalizations.current.update
        : AppLocalizations.current.add;

    void onConfirm(SettingsState state) {
      if (state.serviceType.id.isEmpty) {
        context.read<SettingsCubit>().addServiceType();
      } else {
        context.read<SettingsCubit>().updateServiceType();
      }
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<SettingsCubit>().eraseServiceType();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<SettingsCubit, SettingsState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == BaseStateStatus.success) {
                  context.pop();
                }
              },
              child: BlocBuilder<SettingsCubit, SettingsState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: AddServiceTypeForm(
                        labelButton: label, onConfirm: () => onConfirm(state)),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

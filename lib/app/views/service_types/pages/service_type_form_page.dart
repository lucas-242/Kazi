import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_state.dart';
import '../service_types.dart';

class ServiceTypeFormPage extends StatefulWidget {
  const ServiceTypeFormPage({super.key});

  @override
  State<ServiceTypeFormPage> createState() => _ServiceTypeFormPageState();
}

class _ServiceTypeFormPageState extends State<ServiceTypeFormPage> {
  @override
  Widget build(BuildContext context) {
    final label = context.read<ServiceTypesCubit>().state.serviceType.id != ''
        ? AppLocalizations.current.update
        : AppLocalizations.current.add;

    void onConfirm(ServiceTypesState state) {
      if (state.serviceType.id.isEmpty) {
        context.read<ServiceTypesCubit>().addServiceType();
      } else {
        context.read<ServiceTypesCubit>().updateServiceType();
      }
    }

    return WillPopScope(
      onWillPop: () async {
        context.read<ServiceTypesCubit>().eraseServiceType();
        return true;
      },
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: BlocListener<ServiceTypesCubit, ServiceTypesState>(
              listenWhen: (previous, current) =>
                  previous.status != current.status,
              listener: (context, state) {
                if (state.status == BaseStateStatus.success) {
                  context.pop();
                }
              },
              child: BlocBuilder<ServiceTypesCubit, ServiceTypesState>(
                builder: (context, state) {
                  return Padding(
                    padding: const EdgeInsets.only(top: 25),
                    child: ServiceTypeFormContent(
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

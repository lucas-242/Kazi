import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/service_types/widgets/service_types_content.dart';
import '../service_types.dart';

import 'package:my_services/app/shared/utils/base_state.dart';

class ServiceTypesPage extends StatefulWidget {
  const ServiceTypesPage({super.key});

  @override
  State<ServiceTypesPage> createState() => _ServiceTypesPageState();
}

class _ServiceTypesPageState extends State<ServiceTypesPage> {
  @override
  void initState() {
    context.read<ServiceTypesCubit>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onRefresh: () => context.read<ServiceTypesCubit>().getServiceTypes(),
      child: BlocListener<ServiceTypesCubit, ServiceTypesState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            getCustomSnackBar(
              context,
              message: state.callbackMessage,
            );
          }
        },
        child: BlocBuilder<ServiceTypesCubit, ServiceTypesState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return state.when(
              onState: (_) => ServiceTypesContent(state: state),
              onLoading: () => SizedBox(
                height: context.height,
                child: const Center(child: CircularProgressIndicator()),
              ),
              onNoData: () => const _NoData(),
            );
          },
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
      children: [
        Text(AppLocalizations.current.noServiceTypes,
            style: context.headlineSmall),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => null,
          text: AppLocalizations.current.newService,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/app/views/services_type/widgets/services_type_content.dart';
import '../services_type.dart';

import 'package:my_services/app/shared/utils/base_state.dart';

class ServicesTypePage extends StatefulWidget {
  const ServicesTypePage({super.key});

  @override
  State<ServicesTypePage> createState() => _ServicesTypePageState();
}

class _ServicesTypePageState extends State<ServicesTypePage> {
  @override
  void initState() {
    context.read<ServicesTypeCubit>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      onRefresh: () => context.read<ServicesTypeCubit>().getServiceTypes(),
      child: BlocListener<ServicesTypeCubit, ServicesTypeState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            getCustomSnackBar(
              context,
              message: state.callbackMessage,
            );
          }
        },
        child: BlocBuilder<ServicesTypeCubit, ServicesTypeState>(
          buildWhen: (previous, current) => previous.status != current.status,
          builder: (context, state) {
            return state.when(
              onState: (_) => ServicesTypeContent(state: state),
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

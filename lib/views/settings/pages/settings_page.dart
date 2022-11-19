import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_services/core/routes/app_routes.dart';
import 'package:my_services/shared/themes/themes.dart';
import 'package:my_services/shared/widgets/custom_elevated_button/custom_elevated_button.dart';
import 'package:my_services/views/settings/settings.dart';

import '../../../shared/models/base_state.dart';
import '../../../shared/widgets/custom_app_bar/custom_app_bar_widget.dart';
import '../../../shared/widgets/custom_snack_bar/custom_snack_bar.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    //TODO: RefreshIndicator not working
    return Scaffold(
      appBar: const CustomAppBar(title: 'Configurações'),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<SettingsCubit>().getServiceTypes(),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 25, top: 25),
              child: BlocListener<SettingsCubit, SettingsState>(
                listenWhen: (previous, current) =>
                    previous.status != current.status,
                listener: (context, state) {
                  if (state.status == BaseStateStatus.error) {
                    getCustomSnackBar(
                      context,
                      message: state.callbackMessage,
                      type: SnackBarType.error,
                    );
                  }
                },
                child: BlocBuilder<SettingsCubit, SettingsState>(
                  buildWhen: (previous, current) =>
                      previous.status != current.status,
                  builder: (context, state) {
                    return state.when(
                      onState: (_) => const _Build(),
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
        ),
      ),
    );
  }
}

class _Build extends StatelessWidget {
  const _Build();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tipos de serviços',
          style: context.titleMedium,
        ),
        const SizedBox(height: 25),
        BlocBuilder<SettingsCubit, SettingsState>(builder: (context, state) {
          return ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.serviceTypeList.length,
            itemBuilder: (context, index) => ServiceTypeCard(
              serviceType: state.serviceTypeList[index],
              onTapEdit: (serviceType) {
                context.read<SettingsCubit>().changeServiceType(serviceType);
                Navigator.pushNamed(context, AppRoutes.addServiceType);
              },
              onTapDelete: (serviceType) =>
                  context.read<SettingsCubit>().deleteServiceType(serviceType),
            ),
          );
        }),
        const SizedBox(height: 25),
        Center(
          child: CustomElevatedButton(
            onTap: () => Navigator.pushNamed(context, AppRoutes.addServiceType),
            text: 'Adicionar tipo de serviço',
          ),
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}

class _NoData extends StatelessWidget {
  const _NoData();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Não há serviços cadastrados', style: context.headlineSmall),
        const SizedBox(height: 25),
        Text('Você ainda não cadastrou serviços', style: context.bodyLarge),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => Navigator.pushNamed(context, AppRoutes.addServiceType),
          text: 'Adicionar novo serviço',
        ),
      ],
    );
  }
}

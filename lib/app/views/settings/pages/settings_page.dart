import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import '../settings.dart';

import 'package:my_services/app/shared/utils/base_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    context.read<SettingsCubit>().onInit();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => context.read<SettingsCubit>().getServiceTypes(),
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
                    onState: (_) => _Build(state: state),
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
    );
  }
}

class _Build extends StatelessWidget {
  final SettingsState state;
  const _Build({required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppLocalizations.current.serviceTypes,
              style: context.titleMedium,
            ),
            Text(
              '${state.serviceTypes.length.toString()} ${state.serviceTypes.length > 1 ? AppLocalizations.current.services : AppLocalizations.current.service}',
              style: context.titleMedium,
            ),
          ],
        ),
        const Divider(),
        const SizedBox(height: 10),
        Expanded(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: state.serviceTypes.length,
            itemBuilder: (context, index) => ServiceTypeCard(
              serviceType: state.serviceTypes[index],
              onTapEdit: (serviceType) {
                context.read<SettingsCubit>().changeServiceType(serviceType);
                // context.go(AppRoutes.addServiceType);
              },
              onTapDelete: (serviceType) =>
                  context.read<SettingsCubit>().deleteServiceType(serviceType),
            ),
            separatorBuilder: (context, index) => const Divider(),
          ),
        ),
        const SizedBox(height: 25),
        Center(
          child: CustomElevatedButton(
            onTap: () => context.go(AppRoutes.addServiceType),
            text: AppLocalizations.current.addNewServiceType,
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
        Text(AppLocalizations.current.noServiceTypes,
            style: context.headlineSmall),
        const SizedBox(height: 25),
        CustomElevatedButton(
          onTap: () => null,
          text: AppLocalizations.current.addNewServiceType,
        ),
      ],
    );
  }
}

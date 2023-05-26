import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/routes/app_router.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/shared/widgets/buttons/buttons.dart';
import 'package:kazi/app/views/service_types/service_types.dart';

class ServiceTypesContent extends StatelessWidget {
  const ServiceTypesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypesCubit>();
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          BackAndPill(
            text: AppLocalizations.current.serviceTypes,
            pillText: AppLocalizations.current.newType,
            onTapPill: () => context.go(AppRouter.addServiceType),
            onTapBack: () => context.go(AppRouter.profile),
          ),
          AppSizeConstants.bigVerticalSpacer,
          Card(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSizeConstants.largeSpace,
                right: AppSizeConstants.largeSpace,
                top: AppSizeConstants.tinySpace,
                bottom: AppSizeConstants.mediumSpace,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: cubit.state.serviceTypes.length,
                itemBuilder: (context, index) => ServiceTypeCard(
                  serviceType: cubit.state.serviceTypes[index],
                  onTapEdit: (serviceType) {
                    cubit.changeServiceType(serviceType);
                    context.go(AppRouter.addServiceType);
                  },
                ),
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

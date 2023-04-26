import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/views/service_types/service_types.dart';

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
            text: context.appLocalizations.serviceTypes,
            pillText: context.appLocalizations.newType,
            onTapPill: () => context.go(
              AppRoutes.addServiceType,
              extra: cubit,
            ),
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
                    context.go(
                      AppRoutes.addServiceType,
                      extra: cubit,
                    );
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

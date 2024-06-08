import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/services/service_types/service_types.dart';

class ServiceTypesContent extends StatelessWidget {
  const ServiceTypesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypesCubit>();
    return CustomSingleScrollView(
      children: [
        BackAndPill(
          text: AppLocalizations.current.serviceTypes,
          pillText: AppLocalizations.current.newType,
          onTapPill: () => context.navigateTo(AppPages.addServiceType),
          onTapBack: () => context.navigateTo(AppPages.profile),
        ),
        AppSpacings.verticalXxLg,
        Card(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppInsets.lg,
              right: AppInsets.lg,
              top: AppInsets.xs,
              bottom: AppInsets.md,
            ),
            child: ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cubit.state.serviceTypes.length,
              itemBuilder: (context, index) => ServiceTypeCard(
                serviceType: cubit.state.serviceTypes[index],
                onTapEdit: (serviceType) {
                  cubit.changeServiceType(serviceType);
                  context.navigateTo(AppPages.addServiceType);
                },
              ),
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        ),
      ],
    );
  }
}

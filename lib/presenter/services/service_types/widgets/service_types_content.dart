import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/presenter/services/service_types/service_types.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceTypesContent extends StatelessWidget {
  const ServiceTypesContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServiceTypesCubit>();
    return KaziSingleScrollView(
      children: [
        KaziBackAndPill(
          text: AppLocalizations.current.serviceTypes,
          pillText: AppLocalizations.current.newType,
          onTapPill: () => context.navigateTo(AppPages.addServiceType),
          onTapBack: () => context.navigateTo(AppPages.profile),
        ),
        KaziSpacings.verticalXxLg,
        Card(
          child: Padding(
            padding: const EdgeInsets.only(
              left: KaziInsets.lg,
              right: KaziInsets.lg,
              top: KaziInsets.xs,
              bottom: KaziInsets.md,
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

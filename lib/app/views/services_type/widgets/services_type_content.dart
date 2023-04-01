import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/views/services_type/services_type.dart';

class ServicesTypeContent extends StatelessWidget {
  final ServicesTypeState state;
  const ServicesTypeContent({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BackAndPill(
          pillText: AppLocalizations.current.newType,
          text: AppLocalizations.current.serviceTypes,
          onTapPill: () => context.go(AppRoutes.addServiceType),
        ),
        AppSizeConstants.bigVerticalSpacer,
        Card(
          child: Expanded(
            child: Padding(
              padding: const EdgeInsets.only(
                left: AppSizeConstants.largeSpace,
                right: AppSizeConstants.largeSpace,
                top: AppSizeConstants.tinySpace,
                bottom: AppSizeConstants.mediumSpace,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                itemCount: state.serviceTypes.length,
                itemBuilder: (context, index) => ServiceTypeCard(
                  serviceType: state.serviceTypes[index],
                  onTapEdit: (serviceType) {
                    context
                        .read<ServicesTypeCubit>()
                        .changeServiceType(serviceType);
                  },
                  onTapDelete: (serviceType) => context
                      .read<ServicesTypeCubit>()
                      .deleteServiceType(serviceType),
                ),
                separatorBuilder: (context, index) => const Divider(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

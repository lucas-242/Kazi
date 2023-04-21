import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/shared/extensions/extensions.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/texts/texts.dart';

class ServiceTypeNoDataNavbar extends StatelessWidget {
  const ServiceTypeNoDataNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.symmetric(horizontal: AppSizeConstants.smallSpace),
      child: TextWithTrailing(
        text: context.appLocalizations.serviceTypes,
        trailing: PillButton(
          onTap: () => context.go(AppRoutes.addServiceType),
          child: Text(context.appLocalizations.newType),
        ),
      ),
    );
  }
}

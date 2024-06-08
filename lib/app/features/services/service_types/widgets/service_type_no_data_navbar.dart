import 'package:flutter/material.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/texts/texts.dart';

class ServiceTypeNoDataNavbar extends StatelessWidget {
  const ServiceTypeNoDataNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppInsets.sm),
      child: TextWithTrailing(
        text: AppLocalizations.current.serviceTypes,
        trailing: PillButton(
          onTap: () => context.navigateTo(AppPages.addServiceType),
          child: Text(AppLocalizations.current.newType),
        ),
      ),
    );
  }
}

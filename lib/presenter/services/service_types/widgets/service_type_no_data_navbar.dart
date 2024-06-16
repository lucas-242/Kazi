import 'package:flutter/material.dart';
import 'package:kazi/core/components/texts/texts.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ServiceTypeNoDataNavbar extends StatelessWidget {
  const ServiceTypeNoDataNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: KaziInsets.sm),
      child: TextWithTrailing(
        text: AppLocalizations.current.serviceTypes,
        trailing: KaziPillButton(
          onTap: () => context.pushTo(AppPages.addServiceType),
          child: Text(AppLocalizations.current.newType),
        ),
      ),
    );
  }
}

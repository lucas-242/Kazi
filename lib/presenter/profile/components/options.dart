import 'package:flutter/material.dart';
import 'package:kazi/core/constants/app_onboarding.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/presenter/profile/components/option_button.dart';
import 'package:kazi_design_system/themes/themes.dart';

class Options extends StatelessWidget {
  const Options({super.key, required this.onSignOut});
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: AppOnboarding.stepSix,
      children: [
        OptionButton(
          onTap: () => context.navigateTo(AppPages.servicesType),
          text: AppLocalizations.current.serviceTypes,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: KaziInsets.lg),
          child: Divider(),
        ),
        OptionButton(
          onTap: () => context.navigateTo(AppPages.profileResetPassword),
          text: AppLocalizations.current.changePassword,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: KaziInsets.lg),
          child: Divider(),
        ),
        OptionButton(
          onTap: onSignOut,
          text: AppLocalizations.current.logout,
          textStyle: context.titleSmall!.copyWith(color: KaziColors.red),
        ),
      ],
    );
  }
}

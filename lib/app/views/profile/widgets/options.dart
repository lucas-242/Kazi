import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kazi/app/shared/constants/app_onboarding.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';
import 'package:kazi/app/shared/routes/app_router.dart';
import 'package:kazi/app/shared/themes/themes.dart';
import 'package:kazi/app/views/profile/widgets/option_button.dart';

class Options extends StatelessWidget {
  const Options({super.key, required this.onSignOut});
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Column(
      key: AppOnboarding.stepSix,
      children: [
        OptionButton(
          onTap: () => context.go(AppRouter.servicesType),
          text: AppLocalizations.current.serviceTypes,
        ),
        const Padding(
          padding:
              EdgeInsets.symmetric(horizontal: AppSizeConstants.largeSpace),
          child: Divider(),
        ),
        OptionButton(
          onTap: onSignOut,
          text: AppLocalizations.current.logout,
          textStyle: context.titleSmall!.copyWith(color: AppColors.red),
        ),
      ],
    );
  }
}

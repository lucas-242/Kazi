import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/presenter/login/login.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class EmailConfirmation extends StatelessWidget {
  const EmailConfirmation({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            KaziBackAndPill(
              onTapBack: () => context.navigateTo(AppPages.signIn),
              text: AppLocalizations.current.forgotPassword,
            ),
            KaziSpacings.verticalLg,
            SvgPicture.asset(KaziAssets.email),
            KaziSpacings.verticalXLg,
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                text: AppLocalizations.current.forgotPasswordConfirmation1,
                style: context.bodyMedium,
                children: [
                  TextSpan(
                    text: email,
                    style: context.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: KaziColors.orange,
                    ),
                  ),
                  TextSpan(
                    text: AppLocalizations.current.forgotPasswordConfirmation2,
                  ),
                ],
              ),
            ),
            KaziSpacings.verticalXLg,
            const LoginSignInChanger(),
          ],
        ),
      ],
    );
  }
}

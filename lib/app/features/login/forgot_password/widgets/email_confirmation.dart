import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/features/login/login.dart';

class EmailConfirmation extends StatelessWidget {
  const EmailConfirmation({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            BackAndPill(
              onTapBack: () => context.navigateTo(AppPages.signIn),
              text: AppLocalizations.current.forgotPassword,
            ),
            AppSizeConstants.largeVerticalSpacer,
            SvgPicture.asset(AppAssets.email),
            AppSizeConstants.bigVerticalSpacer,
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
                      color: AppColors.orange,
                    ),
                  ),
                  TextSpan(
                    text: AppLocalizations.current.forgotPasswordConfirmation2,
                  ),
                ],
              ),
            ),
            AppSizeConstants.bigVerticalSpacer,
            const LoginSignInChanger(),
          ],
        ),
      ],
    );
  }
}

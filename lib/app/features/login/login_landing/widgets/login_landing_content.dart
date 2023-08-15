import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/features/login/login.dart';

class LoginLandingContent extends StatelessWidget {
  const LoginLandingContent({super.key, required this.state});

  final LoginState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(
          top: 140,
          bottom: 100,
          left: AppSizeConstants.hugeSpace,
          right: AppSizeConstants.hugeSpace,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        AppAssets.logo,
                        height: AppSizeConstants.logoHeight,
                      ),
                      Text('Kazi', style: context.loginTitle)
                    ],
                  ),
                  AppSizeConstants.smallVerticalSpacer,
                  Text(
                    AppLocalizations.current.appSubtitle,
                    textAlign: TextAlign.center,
                    style: context.headlineMedium,
                  ),
                ],
              ),
              AppSizeConstants.mediumVerticalSpacer,
              if (state.isSigningIn) const SignInForm() else const SignUpForm(),
              AppSizeConstants.mediumVerticalSpacer,
              const LoginTermsPolicies(),
              AppSizeConstants.mediumVerticalSpacer,
              const LoginSignInChanger(),
            ],
          ),
        ),
      ),
    );
  }
}

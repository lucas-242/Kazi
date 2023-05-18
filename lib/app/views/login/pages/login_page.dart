import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/routes/app_routes.dart';
import 'package:my_services/app/shared/themes/themes.dart';
import 'package:my_services/app/shared/widgets/buttons/buttons.dart';
import 'package:my_services/app/shared/widgets/layout/layout.dart';
import 'package:my_services/injector_container.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  void _login() {
    serviceLocator<AuthService>().signInWithGoogle().then((isSignedIn) {
      if (isSignedIn) context.go(AppRoutes.onboarding);
    }).catchError((error) {
      getCustomSnackBar(context, message: error.message);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorsScheme.primary,
      body: Padding(
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
              AppSizeConstants.imenseVerticalSpacer,
              AppSizeConstants.bigVerticalSpacer,
              PillButton(
                onTap: _login,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssets.google,
                      height: 18,
                      colorFilter: const ColorFilter.mode(
                        AppColors.white,
                        BlendMode.srcIn,
                      ),
                    ),
                    AppSizeConstants.smallHorizontalSpacer,
                    Text(AppLocalizations.current.googleSignIn),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/app/features/login/login_form/cubit/login_form_cubit.dart';
import 'package:kazi/app/features/login/login_landing/widgets/login_sign_in_changer.dart';
import 'package:kazi/app/features/login/login_landing/widgets/login_terms_policies.dart';

class LoginLandingPage extends StatefulWidget {
  const LoginLandingPage({super.key});

  @override
  State<LoginLandingPage> createState() => _LoginLandingPageState();
}

class _LoginLandingPageState extends State<LoginLandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginFormCubit(),
      child: BlocConsumer<LoginFormCubit, LoginFormState>(
        listener: (context, state) {
          if (state is LoginFormSuccessState) {
            context.navigateTo(AppPage.onboarding);
          } else if (state is LoginFormErrorState) {
            getCustomSnackBar(context, message: state.message);
          }
        },
        builder: (context, state) {
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
                    AppSizeConstants.mediumVerticalSpacer,
                    if (state.isSigningIn)
                      const SignInForm()
                    else
                      SignUpForm(onTapSignUp: () {}),
                    const LoginTermsPolicies(),
                    const LoginSignInChanger(),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

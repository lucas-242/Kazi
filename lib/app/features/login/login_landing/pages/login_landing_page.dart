import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/app/features/login/login_form/cubit/login_form_cubit.dart';

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
                    const SignInForm(),
                    AppSizeConstants.mediumVerticalSpacer,
                    Text(AppLocalizations.current.or.toUpperCase()),
                    AppSizeConstants.mediumVerticalSpacer,
                    PillButton(
                      onTap: () =>
                          context.read<LoginFormCubit>().onSignInWithGoogle(),
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
                    ),
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.current.userTermsAlert1,
                        children: [
                          TextSpan(
                            text: AppLocalizations.current.userTermsAlert2,
                            style: context.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                          TextSpan(
                              text: AppLocalizations.current.userTermsAlert3),
                          TextSpan(
                            text: AppLocalizations.current.userTermsAlert4,
                            style: context.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    AppSizeConstants.mediumVerticalSpacer,
                    RichText(
                      text: TextSpan(
                        text: AppLocalizations.current.alreadyHasAccont,
                        children: [
                          TextSpan(
                            text: AppLocalizations.current.signIn,
                            style: context.bodyMedium!
                                .copyWith(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
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

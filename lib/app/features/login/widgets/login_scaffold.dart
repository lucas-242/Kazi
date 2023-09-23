import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: CustomSafeArea(
        padding: const EdgeInsets.only(top: AppSizeConstants.largeSpace),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              collapsedHeight: 73,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    AppAssets.logoExtended,
                    height: AppSizeConstants.logoHeight,
                  ),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  AppSizeConstants.largeVerticalSpacer,
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(
                        top: AppSizeConstants.bigSpace,
                        left: AppSizeConstants.bigSpace,
                        right: AppSizeConstants.bigSpace,
                      ),
                      decoration: const BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: const RouterOutlet(),
                      // child: Column(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     Column(
                      //       crossAxisAlignment: CrossAxisAlignment.start,
                      //       children: [
                      //         state.currentLoginPage.chooseLoginPage(
                      //           onSignIn: () => Text(
                      //             AppLocalizations.current.signIn,
                      //             style: context.headlineMedium,
                      //           ),
                      //           onSignUp: () => Text(
                      //             AppLocalizations.current.signUp,
                      //             style: context.headlineMedium,
                      //           ),
                      //           onForgotPassword: () => BackAndPill(
                      //             text: AppLocalizations.current.forgotPassword,
                      //             onTapBack: () => context
                      //                 .read<LoginCubit>()
                      //                 .onChangeLoginPage(LoginPage.signIn),
                      //           ),
                      //           onEmailSent: () => BackAndPill(
                      //             text: AppLocalizations.current.forgotPassword,
                      //             onTapBack: () => context
                      //                 .read<LoginCubit>()
                      //                 .onChangeLoginPage(LoginPage.signIn),
                      //           ),
                      //         ),
                      //         AppSizeConstants.bigVerticalSpacer,
                      //         state.currentLoginPage.chooseLoginPage(
                      //           onSignIn: () => const SignInForm(),
                      //           onSignUp: () => const SignUpForm(),
                      //           onForgotPassword: () =>
                      //               const ForgotPasswordForm(),
                      //           onEmailSent: () =>
                      //               EmailConfirmation(state: state),
                      //         ),
                      //         AppSizeConstants.mediumVerticalSpacer,
                      //       ],
                      //     ),
                      //     if (state.currentLoginPage != LoginPage.forgotPassword)
                      //       LoginSignInChanger(state: state),
                      //   ],
                      // ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

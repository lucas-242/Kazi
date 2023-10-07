import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/features/login/forgot_password/cubit/forgot_password_cubit.dart';

class LoginSignInChanger extends StatelessWidget {
  const LoginSignInChanger({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final currentPage =
        AppPages.fromIndex(context.read<AppCubit>().state.value);

    T chooseFromPage<T>(
      AppPages currentPage, {
      required T Function() onSignIn,
      T Function()? onSignUp,
      T Function()? onEmailConfirmation,
    }) {
      if (currentPage == AppPages.signIn) {
        return onSignIn();
      } else if (currentPage == AppPages.signUp) {
        return onSignUp != null ? onSignUp() : onSignIn();
      }
      return onEmailConfirmation != null ? onEmailConfirmation() : onSignIn();
    }

    return Column(
      children: [
        const Divider(),
        AppSizeConstants.mediumVerticalSpacer,
        MaterialButton(
          onPressed: () => chooseFromPage(
            currentPage,
            onSignIn: () => context.navigateTo(AppPages.signUp),
            onSignUp: () => context.navigateTo(AppPages.signIn),
            onEmailConfirmation: () =>
                context.read<ForgotPasswordCubit>().onForgotPassword(),
          ),
          child: RichText(
            text: TextSpan(
              text: chooseFromPage(
                currentPage,
                onSignIn: () => AppLocalizations.current.doesntHaveAccount,
                onSignUp: () => AppLocalizations.current.alreadyHasAccont,
                onEmailConfirmation: () =>
                    AppLocalizations.current.didntReceiveAnything,
              ),
              style: context.bodyMedium,
              children: [
                TextSpan(
                  text: chooseFromPage(
                    currentPage,
                    onSignIn: () => AppLocalizations.current.signUp,
                    onSignUp: () => AppLocalizations.current.signIn,
                    onEmailConfirmation: () =>
                        AppLocalizations.current.resendEmail,
                  ),
                  style: context.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.orange,
                  ),
                ),
              ],
            ),
          ),
        ),
        AppSizeConstants.mediumVerticalSpacer,
      ],
    );
  }
}

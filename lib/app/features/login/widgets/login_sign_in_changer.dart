import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/features/login/login.dart';

class LoginSignInChanger extends StatelessWidget {
  const LoginSignInChanger({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<LoginCubit>();
    final isSigningIn = cubit.state.isSigningIn;

    return MaterialButton(
      onPressed: () => cubit.onChangeLoginMethod(),
      child: RichText(
        text: TextSpan(
          text: isSigningIn
              ? AppLocalizations.current.doesntHaveAccount
              : AppLocalizations.current.alreadyHasAccont,
          children: [
            TextSpan(
              text: isSigningIn
                  ? AppLocalizations.current.signUp
                  : AppLocalizations.current.signIn,
              style: context.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}

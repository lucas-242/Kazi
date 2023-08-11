import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/cubit/login_cubit.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({
    super.key,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textFormKey: _emailKey,
            labelText: AppLocalizations.current.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) => cubit.onChangeEmail(email),
            validator: (value) => FormValidator.validateEmailField(value),
          ),
          AppSizeConstants.largeVerticalSpacer,
          CustomTextFormField(
            textFormKey: _passwordKey,
            labelText: AppLocalizations.current.password,
            textInputAction: TextInputAction.done,
            onChanged: (password) => cubit.onChangePassword(password),
            validator: (value) => FormValidator.validatePasswordField(value),
          ),
          AppSizeConstants.smallVerticalSpacer,
          Align(
            alignment: Alignment.centerLeft,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.navigateTo(AppPage.login),
              child: Text(
                AppLocalizations.current.forgotPassword,
                style: context.bodyMedium,
              ),
            ),
          ),
          AppSizeConstants.smallVerticalSpacer,
          PillButton(
            onTap: cubit.onSignInWithPassword,
            child: Text(AppLocalizations.current.signIn),
          ),
          AppSizeConstants.smallVerticalSpacer,
          Text(AppLocalizations.current.or.toUpperCase()),
          AppSizeConstants.smallVerticalSpacer,
          PillButton(
            onTap: () => context.read<LoginCubit>().onSignInWithGoogle(),
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
        ],
      ),
    );
  }
}

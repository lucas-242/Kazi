import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/login.dart';

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

  late final TextEditingController passwordController;

  @override
  void initState() {
    final cubit = context.read<LoginCubit>();
    passwordController = TextEditingController(text: cubit.state.password);
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();
    final passwordController =
        TextEditingController(text: cubit.state.password);

    void onTapSignIn() {
      if (_formKey.currentState!.validate()) {
        cubit.onSignInWithPassword();
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textFormKey: _emailKey,
            labelText: AppLocalizations.current.email,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            initialValue: cubit.state.email,
            onChanged: (email) => cubit.onChangeEmail(email),
            validator: (value) => FormValidator.validateEmailField(value),
          ),
          AppSizeConstants.bigVerticalSpacer,
          BlocBuilder<LoginCubit, LoginState>(builder: (context, state) {
            return CustomTextFormField(
              textFormKey: _passwordKey,
              controller: passwordController,
              labelText: AppLocalizations.current.password,
              textCapitalization: TextCapitalization.none,
              textInputAction: TextInputAction.done,
              obscureText: !cubit.state.showPassword,
              onChanged: (password) => cubit.onChangePassword(password),
              validator: (value) => FormValidator.validateTextField(
                  value, AppLocalizations.current.password),
              suffixIcon: IconButton(
                onPressed: () => cubit.onChangeShowPassword(),
                icon: Icon(
                  cubit.state.showPassword
                      ? Icons.visibility
                      : Icons.visibility_off,
                  color: context.colorsScheme.onBackground,
                ),
              ),
            );
          }),
          AppSizeConstants.largeVerticalSpacer,
          Align(
            alignment: Alignment.centerLeft,
            child: MaterialButton(
              padding: EdgeInsets.zero,
              onPressed: () => context.navigateTo(AppPage.forgotPassword),
              child: Text(
                AppLocalizations.current.forgotYourPassword,
                style: context.titleSmall,
              ),
            ),
          ),
          AppSizeConstants.largeVerticalSpacer,
          PillButton(
            onTap: onTapSignIn,
            fillWidth: true,
            child: Text(AppLocalizations.current.signIn),
          ),
          AppSizeConstants.mediumVerticalSpacer,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Expanded(child: Divider(color: AppColors.lightGrey)),
              AppSizeConstants.smallHorizontalSpacer,
              Text(AppLocalizations.current.or, style: context.bodyMedium),
              AppSizeConstants.smallHorizontalSpacer,
              const Expanded(child: Divider(color: AppColors.lightGrey)),
            ],
          ),
          AppSizeConstants.mediumVerticalSpacer,
          PillButton(
            onTap: () => cubit.onSignInWithGoogle(),
            backgroundColor: AppColors.white,
            foregroundColor: AppColors.black,
            fillWidth: true,
            outlinedButton: true,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  AppAssets.google,
                  height: 18,
                ),
                AppSizeConstants.smallHorizontalSpacer,
                Text(AppLocalizations.current.googleSignIn),
              ],
            ),
          ),
          AppSizeConstants.largeVerticalSpacer,
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/login.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({super.key});

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    final cubit = context.read<LoginCubit>();
    passwordController = TextEditingController(text: cubit.state.password);
    confirmPasswordController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    void onTapSignUp() {
      if (_formKey.currentState!.validate()) {
        cubit.onSignUp();
      }
    }

    void clearPasswordFields(LoginState state) {
      if (state.password.isEmpty && passwordController.text.isNotEmpty) {
        passwordController.text = '';
        confirmPasswordController.text = '';
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textFormKey: _nameKey,
            labelText: AppLocalizations.current.name,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            initialValue: cubit.state.name,
            validator: (value) => FormValidator.validateTextField(
              value,
              AppLocalizations.current.name,
            ),
            onChanged: (value) => cubit.onChangeName(value),
          ),
          AppSizeConstants.largeVerticalSpacer,
          CustomTextFormField(
            textFormKey: _emailKey,
            labelText: AppLocalizations.current.email,
            keyboardType: TextInputType.emailAddress,
            textCapitalization: TextCapitalization.none,
            initialValue: cubit.state.email,
            validator: (value) => FormValidator.validateEmailField(value),
            onChanged: (value) => cubit.onChangeEmail(value),
          ),
          AppSizeConstants.largeVerticalSpacer,
          BlocBuilder<LoginCubit, LoginState>(
            builder: (context, state) {
              clearPasswordFields(state);
              return Column(
                children: [
                  CustomTextFormField(
                    textFormKey: _passwordKey,
                    controller: passwordController,
                    labelText: AppLocalizations.current.password,
                    textCapitalization: TextCapitalization.none,
                    obscureText: !cubit.state.showPassword,
                    validator: (value) =>
                        FormValidator.validatePasswordField(value),
                    onChanged: (value) => cubit.onChangePassword(value),
                    suffixIcon: IconButton(
                      onPressed: () => cubit.onChangeShowPassword(),
                      icon: Icon(
                        cubit.state.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.colorsScheme.onBackground,
                      ),
                    ),
                  ),
                  AppSizeConstants.largeVerticalSpacer,
                  CustomTextFormField(
                    textFormKey: _confirmPasswordKey,
                    controller: confirmPasswordController,
                    labelText: AppLocalizations.current.confirmPassword,
                    textCapitalization: TextCapitalization.none,
                    textInputAction: TextInputAction.done,
                    obscureText: !cubit.state.showPassword,
                    validator: (value) =>
                        FormValidator.validateConfirmPasswordField(
                      value,
                      cubit.state.password,
                    ),
                    suffixIcon: IconButton(
                      onPressed: () => cubit.onChangeShowPassword(),
                      icon: Icon(
                        cubit.state.showPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: context.colorsScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          AppSizeConstants.largeVerticalSpacer,
          PillButton(
            onTap: onTapSignUp,
            fillWidth: true,
            child: Text(AppLocalizations.current.signUp),
          ),
          AppSizeConstants.largeVerticalSpacer,
          const LoginTermsPolicies(),
          AppSizeConstants.largeVerticalSpacer,
        ],
      ),
    );
  }
}

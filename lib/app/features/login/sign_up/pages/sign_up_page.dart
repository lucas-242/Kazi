import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/app/features/login/sign_up/cubit/sign_up_cubit.dart';
import 'package:kazi/injector_container.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;

  @override
  void initState() {
    passwordController = TextEditingController(text: '');
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
    void onTapSignUp() {
      final cubit = context.read<SignUpCubit>();
      if (_formKey.currentState!.validate()) {
        cubit.onSignUp();
      }
    }

    void clearPasswordFields(SignUpState state) {
      if (state.password.isEmpty && passwordController.text.isNotEmpty) {
        passwordController.text = '';
        confirmPasswordController.text = '';
      }
    }

    return BlocProvider(
      create: (_) => SignUpCubit(serviceLocator<Auth>()),
      child: LoginScaffold(
        child: BlocConsumer<SignUpCubit, SignUpState>(
          listener: (context, state) {
            if (state.status == BaseStateStatus.error) {
              getCustomSnackBar(context, message: state.callbackMessage);
            }
          },
          builder: (context, state) {
            final cubit = context.read<SignUpCubit>();
            return state.when(
              onLoading: () => const Loading(),
              onState: (_) => Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextFormField(
                      textFormKey: _nameKey,
                      labelText: AppLocalizations.current.name,
                      keyboardType: TextInputType.name,
                      textCapitalization: TextCapitalization.words,
                      initialValue: state.name,
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
                      initialValue: state.email,
                      validator: (value) =>
                          FormValidator.validateEmailField(value),
                      onChanged: (value) => cubit.onChangeEmail(value),
                    ),
                    AppSizeConstants.largeVerticalSpacer,
                    Column(
                      children: [
                        CustomTextFormField(
                          textFormKey: _passwordKey,
                          controller: passwordController,
                          labelText: AppLocalizations.current.password,
                          textCapitalization: TextCapitalization.none,
                          obscureText: !state.showPassword,
                          validator: (value) =>
                              FormValidator.validatePasswordField(value),
                          onChanged: (value) => cubit.onChangePassword(value),
                          suffixIcon: IconButton(
                            onPressed: () => cubit.onChangeShowPassword(),
                            icon: Icon(
                              state.showPassword
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
                          obscureText: !state.showPassword,
                          validator: (value) =>
                              FormValidator.validateConfirmPasswordField(
                            value,
                            state.password,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () => cubit.onChangeShowPassword(),
                            icon: Icon(
                              state.showPassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: context.colorsScheme.onBackground,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSizeConstants.bigVerticalSpacer,
                    PillButton(
                      onTap: onTapSignUp,
                      fillWidth: true,
                      child: Text(AppLocalizations.current.signUp),
                    ),
                    AppSizeConstants.bigVerticalSpacer,
                    const LoginTermsPolicies(),
                    AppSizeConstants.bigVerticalSpacer,
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

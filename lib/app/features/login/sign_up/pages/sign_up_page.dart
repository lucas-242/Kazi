import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/app/features/login/sign_up/cubit/sign_up_cubit.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({
    super.key,
  });

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

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
    void onTapSignUp(SignUpCubit cubit) {
      if (_formKey.currentState!.validate()) {
        cubit.onSignUp();
      }
    }

    void clearPasswordFields() {
      passwordController.text = '';
      confirmPasswordController.text = '';
    }

    return BlocProvider(
      create: (_) => SignUpCubit(),
      child: BlocConsumer<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            context.showSnackBar(
              state.callbackMessage,
              type: SnackBarType.success,
              horizontalMargin: false,
            );
            context.navigateTo(AppPages.signIn);
          } else if (state.status == BaseStateStatus.error) {
            clearPasswordFields();
            context.showSnackBar(state.callbackMessage,
                horizontalMargin: false);
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();
          return state.when(
            onLoading: () => const Loading(height: 0),
            onState: (_) => Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppLocalizations.current.signUp,
                        style: context.headlineMedium,
                      ),
                      AppSizeConstants.bigVerticalSpacer,
                      CustomTextFormField(
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
                        labelText: AppLocalizations.current.email,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        initialValue: state.email,
                        validator: (value) =>
                            FormValidator.validateEmailField(value),
                        onChanged: (value) => cubit.onChangeEmail(value),
                      ),
                      AppSizeConstants.largeVerticalSpacer,
                      CustomTextFormField(
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
                      AppSizeConstants.bigVerticalSpacer,
                      PillButton(
                        onTap: () => onTapSignUp(cubit),
                        fillWidth: true,
                        child: Text(AppLocalizations.current.signUp),
                      ),
                      AppSizeConstants.bigVerticalSpacer,
                      const LoginTermsPolicies(),
                      AppSizeConstants.bigVerticalSpacer,
                    ],
                  ),
                  const LoginSignInChanger(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

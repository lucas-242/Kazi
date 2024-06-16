import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/presenter/login/login.dart';
import 'package:kazi/presenter/login/sign_up/cubit/sign_up_cubit.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/utils/form_validator.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
            onLoading: () => const KaziLoading(height: 0),
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
                      KaziSpacings.verticalXLg,
                      KaziTextFormField(
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
                      KaziSpacings.verticalLg,
                      KaziTextFormField(
                        labelText: AppLocalizations.current.email,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        initialValue: state.email,
                        validator: (value) =>
                            FormValidator.validateEmailField(value),
                        onChanged: (value) => cubit.onChangeEmail(value),
                      ),
                      KaziSpacings.verticalLg,
                      KaziTextFormField(
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
                            color: KaziColors.black,
                          ),
                        ),
                      ),
                      KaziSpacings.verticalLg,
                      KaziTextFormField(
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
                            color: context.colorsScheme.onSurface,
                          ),
                        ),
                      ),
                      KaziSpacings.verticalXLg,
                      KaziPillButton(
                        onTap: () => onTapSignUp(cubit),
                        fillWidth: true,
                        child: Text(AppLocalizations.current.signUp),
                      ),
                      KaziSpacings.verticalXLg,
                      const LoginTermsPolicies(),
                      KaziSpacings.verticalXLg,
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

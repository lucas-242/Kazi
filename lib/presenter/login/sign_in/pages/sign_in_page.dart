import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/presenter/login/login.dart';
import 'package:kazi/presenter/login/sign_in/cubit/sign_in_cubit.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/core/utils/form_validator.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({
    super.key,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController passwordController;

  @override
  void initState() {
    passwordController = TextEditingController(text: '');
    super.initState();
  }

  @override
  void dispose() {
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void onTapSignIn(SignInCubit cubit) {
      if (_formKey.currentState!.validate()) {
        cubit.onSignInWithPassword();
      }
    }

    void clearPasswordField() {
      passwordController.text = '';
    }

    return BlocProvider(
      create: (_) => SignInCubit(),
      child: BlocConsumer<SignInCubit, SignInState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            context.navigateTo(AppPages.onboarding);
          } else if (state.status == BaseStateStatus.error) {
            clearPasswordField();
            context.showSnackBar(state.callbackMessage,
                horizontalMargin: false);
          }
        },
        builder: (context, state) {
          final cubit = context.read<SignInCubit>();
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
                        AppLocalizations.current.signIn,
                        style: context.headlineMedium,
                      ),
                      KaziSpacings.verticalXLg,
                      KaziTextFormField(
                        labelText: AppLocalizations.current.email,
                        keyboardType: TextInputType.emailAddress,
                        textCapitalization: TextCapitalization.none,
                        initialValue: cubit.state.email,
                        onChanged: (email) => cubit.onChangeEmail(email),
                        validator: (value) =>
                            FormValidator.validateEmailField(value),
                      ),
                      KaziSpacings.verticalXLg,
                      KaziTextFormField(
                        controller: passwordController,
                        labelText: AppLocalizations.current.password,
                        textCapitalization: TextCapitalization.none,
                        textInputAction: TextInputAction.done,
                        obscureText: !cubit.state.showPassword,
                        onChanged: (password) =>
                            cubit.onChangePassword(password),
                        validator: (value) => FormValidator.validateTextField(
                            value, AppLocalizations.current.password),
                        suffixIcon: IconButton(
                          onPressed: () => cubit.onChangeShowPassword(),
                          icon: Icon(
                            cubit.state.showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: KaziColors.black,
                          ),
                        ),
                      ),
                      KaziSpacings.verticalLg,
                      Align(
                        alignment: Alignment.centerLeft,
                        child: MaterialButton(
                          padding: EdgeInsets.zero,
                          onPressed: () => RoutesService.navigateTo(
                              context, AppPages.forgotPassword),
                          child: Text(
                            AppLocalizations.current.forgotYourPassword,
                            style: context.titleSmall,
                          ),
                        ),
                      ),
                      KaziSpacings.verticalLg,
                      KaziPillButton(
                        onTap: () => onTapSignIn(cubit),
                        fillWidth: true,
                        child: Text(AppLocalizations.current.signIn),
                      ),
                      //* Uncomment to show login with Google
                      // AppSizeConstants.mediumVerticalSpacer,
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     const Expanded(
                      //         child: Divider(color: KaziColors.lightGrey)),
                      //     AppSizeConstants.smallHorizontalSpacer,
                      //     Text(AppLocalizations.current.or,
                      //         style: context.bodyMedium),
                      //     AppSizeConstants.smallHorizontalSpacer,
                      //     const Expanded(
                      //         child: Divider(color: KaziColors.lightGrey)),
                      //   ],
                      // ),
                      // AppSizeConstants.mediumVerticalSpacer,
                      // KaziPillButton(
                      //   onTap: () => cubit.onSignInWithGoogle(),
                      //   backgroundColor: KaziColors.white,
                      //   foregroundColor: KaziColors.black,
                      //   fillWidth: true,
                      //   outlinedButton: true,
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       SvgPicture.asset(
                      //         KaziAssets.google,
                      //         height: 18,
                      //       ),
                      //       AppSizeConstants.smallHorizontalSpacer,
                      //       Text(AppLocalizations.current.googleSignIn),
                      //     ],
                      //   ),
                      // ),
                      KaziSpacings.verticalLg,
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

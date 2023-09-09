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
import 'package:kazi/injector_container.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, this.resetPasswordToken});

  final String? resetPasswordToken;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordKey = GlobalKey<FormFieldState>();
  final _newPasswordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  bool get _isFromProfilePage => widget.resetPasswordToken == null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(serviceLocator<Auth>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            getCustomSnackBar(
              context,
              type: SnackBarType.success,
              message: state.callbackMessage,
            );
          } else if (state.status == BaseStateStatus.error) {
            getCustomSnackBar(context, message: state.callbackMessage);
          }
        },
        builder: (context, state) {
          final cubit = context.read<LoginCubit>();

          void onTapSubmit() {
            if (_formKey.currentState!.validate()) {
              if (_isFromProfilePage) {
                cubit.onResetPasswordWithoutToken();
              } else {
                cubit.onResetPassword(widget.resetPasswordToken!);
              }
            }
          }

          return Scaffold(
            backgroundColor: _isFromProfilePage
                ? context.colorsScheme.background
                : context.colorsScheme.primary,
            body: CustomSafeArea(
              child: state.when(
                onState: (_) => SingleChildScrollView(
                  child: Column(
                    children: [
                      BackAndPill(
                        text: AppLocalizations.current.resetPassword,
                      ),
                      Icon(
                        Icons.password,
                        size: _isFromProfilePage ? 210 : 280,
                      ),
                      AppSizeConstants.mediumVerticalSpacer,
                      Padding(
                        padding: const EdgeInsets.only(
                          left: AppSizeConstants.hugeSpace,
                          right: AppSizeConstants.hugeSpace,
                        ),
                        child: Column(
                          children: [
                            Text(
                              AppLocalizations.current.resetPasswordInfo,
                              style: context.titleSmall,
                            ),
                            AppSizeConstants.largeVerticalSpacer,
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  if (widget.resetPasswordToken == null)
                                    CustomTextFormField(
                                      textFormKey: _currentPasswordKey,
                                      labelText: AppLocalizations
                                          .current.currentPassword,
                                      textCapitalization:
                                          TextCapitalization.none,
                                      obscureText: !cubit.state.showPassword,
                                      validator: (value) =>
                                          FormValidator.validateTextField(
                                        value,
                                        AppLocalizations
                                            .current.currentPassword,
                                      ),
                                      onChanged: (value) =>
                                          cubit.onChangeCurrentPassword(value),
                                      suffixIcon: IconButton(
                                        onPressed: () =>
                                            cubit.onChangeShowPassword(),
                                        icon: Icon(
                                          cubit.state.showPassword
                                              ? Icons.visibility
                                              : Icons.visibility_off,
                                          color:
                                              context.colorsScheme.onBackground,
                                        ),
                                      ),
                                    ),
                                  AppSizeConstants.largeVerticalSpacer,
                                  CustomTextFormField(
                                    textFormKey: _newPasswordKey,
                                    labelText:
                                        AppLocalizations.current.newPassword,
                                    textCapitalization: TextCapitalization.none,
                                    obscureText: !cubit.state.showPassword,
                                    validator: (value) =>
                                        FormValidator.validatePasswordField(
                                            value),
                                    onChanged: (value) =>
                                        cubit.onChangePassword(value),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          cubit.onChangeShowPassword(),
                                      icon: Icon(
                                        cubit.state.showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            context.colorsScheme.onBackground,
                                      ),
                                    ),
                                  ),
                                  AppSizeConstants.largeVerticalSpacer,
                                  CustomTextFormField(
                                    textFormKey: _confirmPasswordKey,
                                    labelText: AppLocalizations
                                        .current.confirmPassword,
                                    textCapitalization: TextCapitalization.none,
                                    textInputAction: TextInputAction.done,
                                    obscureText: !cubit.state.showPassword,
                                    validator: (value) => FormValidator
                                        .validateConfirmPasswordField(
                                      value,
                                      cubit.state.password,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () =>
                                          cubit.onChangeShowPassword(),
                                      icon: Icon(
                                        cubit.state.showPassword
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color:
                                            context.colorsScheme.onBackground,
                                      ),
                                    ),
                                  ),
                                  AppSizeConstants.mediumVerticalSpacer,
                                  PillButton(
                                    onTap: onTapSubmit,
                                    child: Text(
                                        AppLocalizations.current.resetPassword),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                onLoading: () => Loading(
                  color: context.colorsScheme.onBackground,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

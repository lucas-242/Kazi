import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/core/components/reset_password/cubit/reset_password_cubit.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/utils/form_validator.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ResetPasswordForm extends StatefulWidget {
  const ResetPasswordForm({
    super.key,
    this.resetPasswordToken,
    required this.currentPasswordController,
    required this.newPasswordController,
    required this.confirmPasswordController,
  });

  final String? resetPasswordToken;
  final TextEditingController currentPasswordController;
  final TextEditingController newPasswordController;
  final TextEditingController confirmPasswordController;

  @override
  State<ResetPasswordForm> createState() => _ResetPasswordFormState();
}

class _ResetPasswordFormState extends State<ResetPasswordForm> {
  final _formKey = GlobalKey<FormState>();

  bool get _isFromProfilePage => widget.resetPasswordToken == null;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResetPasswordCubit>();

    void onTapSubmit() {
      if (_formKey.currentState!.validate()) {
        if (_isFromProfilePage) {
          cubit.onResetPasswordWithoutToken();
        } else {
          cubit.onResetPassword(widget.resetPasswordToken!);
        }
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (_isFromProfilePage)
            Padding(
              padding: const EdgeInsets.only(bottom: KaziInsets.xxxLg),
              child: KaziTextFormField(
                labelText: AppLocalizations.current.currentPassword,
                textCapitalization: TextCapitalization.none,
                obscureText: !cubit.state.showPassword,
                validator: (value) => FormValidator.validateTextField(
                  value,
                  AppLocalizations.current.currentPassword,
                ),
                onChanged: (value) => cubit.onChangeCurrentPassword(value),
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
            ),
          KaziTextFormField(
            labelText: AppLocalizations.current.newPassword,
            textCapitalization: TextCapitalization.none,
            obscureText: !cubit.state.showPassword,
            validator: (value) => FormValidator.validatePasswordField(value),
            onChanged: (value) => cubit.onChangePassword(value),
            suffixIcon: IconButton(
              onPressed: () => cubit.onChangeShowPassword(),
              icon: Icon(
                cubit.state.showPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: context.colorsScheme.onSurface,
              ),
            ),
          ),
          KaziSpacings.verticalLg,
          KaziTextFormField(
            labelText: AppLocalizations.current.confirmPassword,
            textCapitalization: TextCapitalization.none,
            textInputAction: TextInputAction.done,
            obscureText: !cubit.state.showPassword,
            validator: (value) => FormValidator.validateConfirmPasswordField(
              value,
              cubit.state.password,
            ),
            suffixIcon: IconButton(
              onPressed: () => cubit.onChangeShowPassword(),
              icon: Icon(
                cubit.state.showPassword
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: context.colorsScheme.onSurface,
              ),
            ),
          ),
          KaziSpacings.verticalMd,
          KaziPillButton(
            onTap: onTapSubmit,
            child: Text(AppLocalizations.current.updatePassword),
          ),
        ],
      ),
    );
  }
}

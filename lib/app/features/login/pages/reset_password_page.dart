import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/login.dart';

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

  @override
  void initState() {
    context
        .read<LoginCubit>()
        .onChangeResetPasswordToken(widget.resetPasswordToken);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    void onTapSubmit() {
      if (_formKey.currentState!.validate()) {
        cubit.onResetPassword();
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          if (widget.resetPasswordToken == null)
            CustomTextFormField(
              textFormKey: _currentPasswordKey,
              labelText: AppLocalizations.current.password,
              textCapitalization: TextCapitalization.none,
              obscureText: !cubit.state.showPassword,
              validator: (value) => FormValidator.validateTextField(
                  value, AppLocalizations.current.password),
              onChanged: (value) => cubit.onChangeCurrentPassword(value),
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
            textFormKey: _newPasswordKey,
            labelText: AppLocalizations.current.password,
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
                color: context.colorsScheme.onBackground,
              ),
            ),
          ),
          AppSizeConstants.largeVerticalSpacer,
          CustomTextFormField(
            textFormKey: _confirmPasswordKey,
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
                color: context.colorsScheme.onBackground,
              ),
            ),
          ),
          AppSizeConstants.smallVerticalSpacer,
          PillButton(
            onTap: onTapSubmit,
            child: Text(AppLocalizations.current.resetPassword),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/settings/app_size_constants.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/login_form/cubit/login_form_cubit.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.onTapSignUp,
  });

  final VoidCallback onTapSignUp;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _confirmPasswordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginFormCubit>();

    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomTextFormField(
            textFormKey: _nameKey,
            labelText: AppLocalizations.current.name,
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            validator: (value) => FormValidator.validateTextField(
              value,
              AppLocalizations.current.name,
            ),
          ),
          AppSizeConstants.largeVerticalSpacer,
          CustomTextFormField(
            textFormKey: _emailKey,
            labelText: AppLocalizations.current.email,
            keyboardType: TextInputType.emailAddress,
            validator: (value) => FormValidator.validateEmailField(value),
          ),
          AppSizeConstants.largeVerticalSpacer,
          CustomTextFormField(
            textFormKey: _passwordKey,
            labelText: AppLocalizations.current.password,
            validator: (value) => FormValidator.validatePasswordField(value),
          ),
          AppSizeConstants.largeVerticalSpacer,
          CustomTextFormField(
            textFormKey: _confirmPasswordKey,
            labelText: AppLocalizations.current.confirmPassword,
            textInputAction: TextInputAction.done,
            validator: (value) => FormValidator.validateConfirmPasswordField(
              value,
              cubit.state.password,
            ),
          ),
          AppSizeConstants.largeVerticalSpacer,
          PillButton(
            onTap: widget.onTapSignUp,
            child: Text(AppLocalizations.current.signUp),
          ),
        ],
      ),
    );
  }
}

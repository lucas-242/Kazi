import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/login.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LoginCubit>();

    void onTapSubmit() {
      if (_formKey.currentState!.validate()) {
        cubit.onForgotPassword();
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
          AppSizeConstants.smallVerticalSpacer,
          PillButton(
            onTap: onTapSubmit,
            child: Text(AppLocalizations.current.signIn),
          ),
        ],
      ),
    );
  }
}

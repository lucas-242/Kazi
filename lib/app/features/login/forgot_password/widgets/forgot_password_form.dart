import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/features/login/forgot_password/cubit/forgot_password_cubit.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgotPasswordCubit>();

    void onTapSubmit() {
      final cubit = context.read<ForgotPasswordCubit>();
      if (_formKey.currentState!.validate()) {
        cubit.onForgotPassword();
      }
    }

    return Column(
      children: [
        BackAndPill(
          onTapBack: () => context.navigateTo(AppPage.signIn),
          text: AppLocalizations.current.forgotPassword,
        ),
        AppSizeConstants.largeVerticalSpacer,
        Text(
          AppLocalizations.current.forgotPasswordInfo,
          style: context.titleSmall,
        ),
        AppSizeConstants.bigVerticalSpacer,
        Form(
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
              AppSizeConstants.bigVerticalSpacer,
              PillButton(
                onTap: onTapSubmit,
                fillWidth: true,
                child: Text(AppLocalizations.current.sendEmail),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

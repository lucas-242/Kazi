import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/presenter/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/form_validator.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

class ForgotPasswordForm extends StatefulWidget {
  const ForgotPasswordForm({super.key});

  @override
  State<ForgotPasswordForm> createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();

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
        KaziBackAndPill(
          onTapBack: () => context.navigateTo(AppPages.signIn),
          text: AppLocalizations.current.forgotPassword,
        ),
        KaziSpacings.verticalLg,
        Text(
          AppLocalizations.current.forgotPasswordInfo,
          style: context.titleSmall,
        ),
        KaziSpacings.verticalXLg,
        Form(
          key: _formKey,
          child: Column(
            children: [
              KaziTextFormField(
                labelText: AppLocalizations.current.email,
                keyboardType: TextInputType.emailAddress,
                textCapitalization: TextCapitalization.none,
                initialValue: cubit.state.email,
                onChanged: (email) => cubit.onChangeEmail(email),
                validator: (value) => FormValidator.validateEmailField(value),
              ),
              KaziSpacings.verticalXLg,
              KaziPillButton(
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

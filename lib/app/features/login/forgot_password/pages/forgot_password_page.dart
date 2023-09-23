import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/utils/form_validator.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/fields/fields.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kazi/injector_container.dart';

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
    void onTapSubmit() {
      final cubit = context.read<ForgotPasswordCubit>();
      if (_formKey.currentState!.validate()) {
        cubit.onForgotPassword();
      }
    }

    return BlocProvider(
      create: (_) => ForgotPasswordCubit(serviceLocator<Auth>()),
      child: Column(
        children: [
          Text(
            AppLocalizations.current.forgotPasswordInfo,
            style: context.titleSmall,
          ),
          AppSizeConstants.bigVerticalSpacer,
          BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
            listener: (context, state) {
              if (state.status == BaseStateStatus.success) {
                getCustomSnackBar(
                  context,
                  type: SnackBarType.success,
                  message: state.callbackMessage,
                );
                context.navigateTo(AppPage.signIn);
              } else if (state.status == BaseStateStatus.error) {
                getCustomSnackBar(context, message: state.callbackMessage);
              }
            },
            builder: (context, state) {
              final cubit = context.read<ForgotPasswordCubit>();
              return state.when(
                onLoading: () => const Loading(),
                onState: (_) => Form(
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
                        validator: (value) =>
                            FormValidator.validateEmailField(value),
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
              );
            },
          ),
        ],
      ),
    );
  }
}

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
import 'package:kazi/app/features/login/login.dart';
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
      final cubit = context.read<LoginCubit>();
      if (_formKey.currentState!.validate()) {
        cubit.onForgotPassword();
      }
    }

    return BlocProvider(
      create: (_) => LoginCubit(serviceLocator<Auth>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            context.navigateTo(AppPage.login);
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

          return Scaffold(
            backgroundColor: context.colorsScheme.primary,
            body: CustomSafeArea(
              child: state.when(
                onState: (_) => SingleChildScrollView(
                  child: Column(
                    children: [
                      BackAndPill(
                        text: AppLocalizations.current.forgotPassword,
                      ),
                      AppSizeConstants.mediumVerticalSpacer,
                      const Icon(
                        Icons.password,
                        size: 280,
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
                                  CustomTextFormField(
                                    textFormKey: _emailKey,
                                    labelText: AppLocalizations.current.email,
                                    keyboardType: TextInputType.emailAddress,
                                    textCapitalization: TextCapitalization.none,
                                    initialValue: cubit.state.email,
                                    onChanged: (email) =>
                                        cubit.onChangeEmail(email),
                                    validator: (value) =>
                                        FormValidator.validateEmailField(value),
                                  ),
                                  AppSizeConstants.mediumVerticalSpacer,
                                  PillButton(
                                    onTap: onTapSubmit,
                                    child: Text(AppLocalizations.current.send),
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

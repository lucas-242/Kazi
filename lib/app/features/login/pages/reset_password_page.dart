import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/reset_password/cubit/reset_password_cubit.dart';
import 'package:kazi/app/features/login/reset_password/widgets/reset_password_form.dart';
import 'package:kazi/injector_container.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, this.resetPasswordToken});

  final String? resetPasswordToken;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  bool get _isFromProfilePage => widget.resetPasswordToken == null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ResetPasswordCubit(serviceLocator<Auth>()),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
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
        builder: (context, state) => Scaffold(
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
                          ResetPasswordForm(
                            resetPasswordToken: widget.resetPasswordToken,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onLoading: () => const Loading(),
            ),
          ),
        ),
      ),
    );
  }
}

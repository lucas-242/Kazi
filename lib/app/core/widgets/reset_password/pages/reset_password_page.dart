import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/buttons/buttons.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/core/widgets/reset_password/cubit/reset_password_cubit.dart';
import 'package:kazi/app/core/widgets/reset_password/widgets/reset_password_form.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key, this.resetPasswordToken});

  final String? resetPasswordToken;

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool get _isFromProfilePage => widget.resetPasswordToken == null;

  @override
  Widget build(BuildContext context) {
    void clearPasswordFields() {
      _currentPasswordController.text = '';
      _newPasswordController.text = '';
      _confirmPasswordController.text = '';
    }

    return BlocProvider(
      create: (_) => ResetPasswordCubit(),
      child: BlocConsumer<ResetPasswordCubit, ResetPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.success) {
            context.showSnackBar(
              state.callbackMessage,
              type: SnackBarType.success,
              horizontalMargin: _isFromProfilePage,
            );
            context.navigateTo(AppPages.signIn);
          } else if (state.status == BaseStateStatus.error) {
            context.showSnackBar(
              state.callbackMessage,
              horizontalMargin: _isFromProfilePage,
            );
            clearPasswordFields();
          }
        },
        builder: (context, state) => state.when(
          onState: (_) => SingleChildScrollView(
            child: Padding(
              padding: _isFromProfilePage
                  ? const EdgeInsets.only(
                      left: AppInsets.lg,
                      right: AppInsets.lg,
                      top: AppInsets.lg,
                    )
                  : EdgeInsets.zero,
              child: Column(
                children: [
                  BackAndPill(
                    onTapBack: () => _isFromProfilePage
                        ? context.navigateBack()
                        : context.navigateTo(AppPages.signIn),
                    text: AppLocalizations.current.changePassword,
                  ),
                  AppSpacings.verticalLg,
                  ResetPasswordForm(
                    resetPasswordToken: widget.resetPasswordToken,
                    confirmPasswordController: _confirmPasswordController,
                    currentPasswordController: _currentPasswordController,
                    newPasswordController: _newPasswordController,
                  ),
                ],
              ),
            ),
          ),
          onLoading: () => Loading(height: _isFromProfilePage ? null : 0),
        ),
      ),
    );
  }
}

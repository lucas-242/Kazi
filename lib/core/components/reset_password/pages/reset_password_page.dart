import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/core/components/reset_password/cubit/reset_password_cubit.dart';
import 'package:kazi/core/components/reset_password/widgets/reset_password_form.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi_design_system/kazi_design_system.dart';
import 'package:kazi_design_system/themes/themes.dart';

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
                      left: KaziInsets.lg,
                      right: KaziInsets.lg,
                      top: KaziInsets.lg,
                    )
                  : EdgeInsets.zero,
              child: Column(
                children: [
                  KaziBackAndPill(
                    onTapBack: () => _isFromProfilePage
                        ? context.navigateBack()
                        : context.navigateTo(AppPages.signIn),
                    text: AppLocalizations.current.changePassword,
                  ),
                  KaziSpacings.verticalLg,
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
          onLoading: () => KaziLoading(height: _isFromProfilePage ? null : 0),
        ),
      ),
    );
  }
}

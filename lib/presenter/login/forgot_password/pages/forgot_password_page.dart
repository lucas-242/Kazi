import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/presenter/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kazi/presenter/login/forgot_password/widgets/email_confirmation.dart';
import 'package:kazi/presenter/login/forgot_password/widgets/forgot_password_form.dart';
import 'package:kazi/core/routes/routes.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi_design_system/kazi_design_system.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            context.showSnackBar(
              state.callbackMessage,
              hasBottomNavigation: false,
              horizontalMargin: false,
            );
          }
        },
        builder: (context, state) {
          return state.when(
            onLoading: () => const KaziLoading(height: 0),
            onInitial: (_) => const ForgotPasswordForm(),
            onError: (_) => const ForgotPasswordForm(),
            onState: (_) => EmailConfirmation(email: state.email),
          );
        },
      ),
    );
  }
}

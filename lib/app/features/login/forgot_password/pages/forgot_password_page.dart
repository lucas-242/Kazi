import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kazi/app/features/login/forgot_password/widgets/email_confirmation.dart';
import 'package:kazi/app/features/login/forgot_password/widgets/forgot_password_form.dart';

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
            context.showSnackBar(state.callbackMessage,
                horizontalMargin: false);
          }
        },
        builder: (context, state) {
          return state.when(
            onLoading: () => const Loading(height: 0),
            onInitial: (_) => const ForgotPasswordForm(),
            onState: (_) => EmailConfirmation(email: state.email),
          );
        },
      ),
    );
  }
}

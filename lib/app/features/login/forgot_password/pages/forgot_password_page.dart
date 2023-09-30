import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/forgot_password/cubit/forgot_password_cubit.dart';
import 'package:kazi/app/features/login/forgot_password/widgets/email_confirmation.dart';
import 'package:kazi/app/features/login/forgot_password/widgets/forgot_password_form.dart';
import 'package:kazi/injector_container.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ForgotPasswordCubit(serviceLocator<Auth>()),
      child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.error) {
            getCustomSnackBar(context, message: state.callbackMessage);
          }
        },
        builder: (context, state) {
          return state.when(
            onLoading: () => const Loading(),
            onInitial: (_) => const ForgotPasswordForm(),
            onState: (_) => EmailConfirmation(email: state.email),
          );
        },
      ),
    );
  }
}

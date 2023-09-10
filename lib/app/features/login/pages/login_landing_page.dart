import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/extensions/extensions.dart';
import 'package:kazi/app/core/themes/themes.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/core/widgets/layout/layout.dart';
import 'package:kazi/app/features/login/login.dart';
import 'package:kazi/injector_container.dart';

class LoginLandingPage extends StatefulWidget {
  const LoginLandingPage({super.key});

  @override
  State<LoginLandingPage> createState() => _LoginLandingPageState();
}

class _LoginLandingPageState extends State<LoginLandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LoginCubit(serviceLocator<Auth>()),
      child: BlocConsumer<LoginCubit, LoginState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == BaseStateStatus.success && state.isSigningIn) {
            context.navigateTo(AppPage.onboarding);
          } else if (state.status == BaseStateStatus.success &&
              !state.isSigningIn) {
            context.read<LoginCubit>().onChangeLoginMethod();
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
          backgroundColor: context.colorsScheme.primary,
          body: CustomSafeArea(
            padding: const EdgeInsets.only(top: AppSizeConstants.largeSpace),
            child: state.when(
              onState: (_) => LoginLandingContent(state: state),
              onLoading: () => Loading(
                color: context.colorsScheme.onBackground,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

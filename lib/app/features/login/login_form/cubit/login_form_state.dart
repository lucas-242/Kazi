part of 'login_form_cubit.dart';

sealed class LoginFormState extends Equatable {
  const LoginFormState({
    required this.email,
    required this.password,
    required this.isSigningIn,
  });

  final String email;
  final String password;
  final bool isSigningIn;

  @override
  List<Object> get props => [email, password, isSigningIn];
}

final class LoginFormInitialState extends LoginFormState {
  const LoginFormInitialState({
    super.email = '',
    super.password = '',
    super.isSigningIn = true,
  });
}

final class LoginFormLoadingState extends LoginFormState {
  const LoginFormLoadingState({
    super.email = '',
    super.password = '',
    super.isSigningIn = true,
  });
}

final class LoginFormSuccessState extends LoginFormState {
  const LoginFormSuccessState({super.isSigningIn = true})
      : super(email: '', password: '');
}

final class LoginFormErrorState extends LoginFormState {
  const LoginFormErrorState({
    required this.message,
    super.email = '',
    super.isSigningIn = true,
  }) : super(password: '');

  final String message;
}

part of 'login_cubit.dart';

sealed class LoginState extends Equatable {
  const LoginState({
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

final class LoginInitialState extends LoginState {
  const LoginInitialState({
    super.email = '',
    super.password = '',
    super.isSigningIn = true,
  });
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState({
    super.email = '',
    super.password = '',
    super.isSigningIn = true,
  });
}

final class LoginSuccessState extends LoginState {
  const LoginSuccessState({super.isSigningIn = true})
      : super(email: '', password: '');
}

final class LoginErrorState extends LoginState {
  const LoginErrorState({
    required this.message,
    super.email = '',
    super.isSigningIn = true,
  }) : super(password: '');

  final String message;
}

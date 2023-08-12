import 'package:equatable/equatable.dart';

part of 'login_cubit.dart';
class LoginState extends Equatable {
  const LoginState({
     this.email = '',
     this.password = '',
     this.isSigningIn = true,
     this.showPassword = false,
  });

  final String email;
  final String password;
  final bool isSigningIn;
  final bool showPassword;

  @override
  List<Object> get props => [email, password, isSigningIn, showPassword];


  LoginState copyWith({
    String? email,
    String? password,
    bool? isSigningIn,
    bool? showPassword,
  }) {
    return LoginState (
      email: email ?? this.email,
      password: password ?? this.password,
      isSigningIn: isSigningIn ?? this.isSigningIn,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

final class LoginLoadingState extends LoginState {
  const LoginLoadingState({
    super.email,
    super.password,
    super.isSigningIn = true,
    super.showPassword = false,
  });

  @override
  LoginLoadingState copyWith({
    String? email,
    String? password,
    bool? isSigningIn,
    bool? showPassword,
  }) {
    return LoginLoadingState (
      email: email ?? this.email,
      password: password ?? this.password,
      isSigningIn: isSigningIn ?? this.isSigningIn,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

final class LoginSuccessState extends LoginState {
  const LoginSuccessState();
}

final class LoginErrorState extends LoginState {
  const LoginErrorState({
    required this.message,
    super.email,
    super.isSigningIn ,
    super.showPassword,
  });

  final String message;
}

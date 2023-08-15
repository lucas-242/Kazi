part of 'login_cubit.dart';

class LoginState extends BaseState with EquatableMixin {
  LoginState({
    required super.status,
    super.callbackMessage,
    this.name = '',
    this.email = '',
    this.password = '',
    this.isSigningIn = true,
    this.showPassword = false,
  });

  final String name;
  final String email;
  final String password;
  final bool isSigningIn;
  final bool showPassword;

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        name,
        email,
        password,
        isSigningIn,
        showPassword,
      ];

  @override
  LoginState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? name,
    String? email,
    String? password,
    bool? isSigningIn,
    bool? showPassword,
  }) {
    return LoginState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      isSigningIn: isSigningIn ?? this.isSigningIn,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

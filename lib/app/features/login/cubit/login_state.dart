part of 'login_cubit.dart';

class LoginState extends BaseState with EquatableMixin {
  LoginState({
    required super.status,
    super.callbackMessage,
    this.name = '',
    this.email = '',
    this.password = '',
    this.currentPassword = '',
    this.resetPasswordToken,
    this.isSigningIn = true,
    this.showPassword = false,
  });

  final String name;
  final String email;
  final String password;
  final String currentPassword;
  final String? resetPasswordToken;
  final bool isSigningIn;
  final bool showPassword;

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        name,
        email,
        password,
        currentPassword,
        resetPasswordToken,
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
    String? currentPassword,
    String? resetPasswordToken,
    bool? isSigningIn,
    bool? showPassword,
  }) {
    return LoginState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
      isSigningIn: isSigningIn ?? this.isSigningIn,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

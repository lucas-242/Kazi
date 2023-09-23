part of 'sign_in_cubit.dart';

class SignInState extends BaseState with EquatableMixin {
  SignInState({
    required super.status,
    super.callbackMessage,
    this.email = '',
    this.password = '',
    this.showPassword = false,
  });

  final String email;
  final String password;
  final bool showPassword;

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        email,
        password,
        showPassword,
      ];

  @override
  SignInState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? email,
    String? password,
    bool? showPassword,
  }) {
    return SignInState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

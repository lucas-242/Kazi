part of 'sign_up_cubit.dart';

class SignUpState extends BaseState with EquatableMixin {
  SignUpState({
    required super.status,
    super.callbackMessage,
    this.name = '',
    this.email = '',
    this.password = '',
    this.showPassword = false,
  });

  final String name;
  final String email;
  final String password;
  final bool showPassword;

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        name,
        email,
        password,
        showPassword,
      ];

  @override
  SignUpState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? name,
    String? email,
    String? password,
    bool? showPassword,
  }) {
    return SignUpState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

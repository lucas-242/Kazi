part of 'reset_password_cubit.dart';

class ResetPasswordState extends BaseState with EquatableMixin {
  ResetPasswordState({
    required super.status,
    super.callbackMessage,
    this.password = '',
    this.currentPassword = '',
    this.resetPasswordToken,
    this.showPassword = false,
  });

  final String password;
  final String currentPassword;
  final String? resetPasswordToken;
  final bool showPassword;

  @override
  List<Object?> get props => [
        status,
        callbackMessage,
        password,
        currentPassword,
        resetPasswordToken,
        showPassword,
      ];

  @override
  ResetPasswordState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? password,
    String? currentPassword,
    String? resetPasswordToken,
    bool? showPassword,
  }) {
    return ResetPasswordState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      password: password ?? this.password,
      currentPassword: currentPassword ?? this.currentPassword,
      resetPasswordToken: resetPasswordToken ?? this.resetPasswordToken,
      showPassword: showPassword ?? this.showPassword,
    );
  }
}

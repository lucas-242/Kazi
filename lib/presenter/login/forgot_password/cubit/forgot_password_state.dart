part of 'forgot_password_cubit.dart';

class ForgotPasswordState extends BaseState with EquatableMixin {
  ForgotPasswordState({
    required super.status,
    super.callbackMessage,
    this.email = '',
  });

  final String email;

  @override
  List<Object?> get props => [status, callbackMessage, email];

  @override
  ForgotPasswordState copyWith({
    BaseStateStatus? status,
    String? callbackMessage,
    String? email,
  }) {
    return ForgotPasswordState(
      status: status ?? this.status,
      callbackMessage: callbackMessage ?? this.callbackMessage,
      email: email ?? this.email,
    );
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authService)
      : super(LoginState(status: BaseStateStatus.initial));

  final AuthService _authService;

  void onChangeEmail(String email) => emit(state.copyWith(email: email));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: password));

  void onChangeLoginMethod() =>
      emit(state.copyWith(isSigningIn: !state.isSigningIn));

  void onChangeShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  Future<void> onSignInWithPassword() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _handleSignInResponse(
        _authService.signInWithPassword(state.email, state.password));
  }

  Future<void> _handleSignInResponse(Future<bool> response) async {
    try {
      final isSignedIn = await response;

      if (isSignedIn) {
        return emit(state.copyWith(status: BaseStateStatus.success));
      }

      return emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
        password: '',
      ));
    } on AppError catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: error.message,
        password: '',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
        password: '',
      ));
    }
  }

  Future<void> onSignInWithGoogle() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _handleSignInResponse(_authService.signInWithGoogle());
  }

  Future<void> onSignUp() async {}
}

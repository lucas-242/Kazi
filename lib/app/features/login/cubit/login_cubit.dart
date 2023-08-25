import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authService)
      : super(LoginState(status: BaseStateStatus.initial));

  final Auth _authService;

  void onChangeName(String name) => emit(state.copyWith(name: name));

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

      return _emitUnknowError();
    } on AppError catch (error) {
      _emitAppError(error);
    } catch (error) {
      _emitUnknowError();
    }
  }

  void _emitAppError(AppError error) => emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: error.message,
        password: '',
      ));

  void _emitUnknowError() => emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
        password: '',
      ));

  Future<void> onSignInWithGoogle() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _handleSignInResponse(_authService.signInWithGoogle());
  }

  Future<void> onSignUp() async {
    try {
      if (!_canSignUp) {
        return;
      }

      final user = User.toCreate(
        name: state.name,
        email: state.email,
        password: state.password,
      );

      await _authService.signUp(user);
      return emit(state.copyWith(
        status: BaseStateStatus.success,
        callbackMessage: AppLocalizations.current.signUpSuccess,
        name: '',
        email: '',
        password: '',
      ));
    } on AppError catch (error) {
      _emitAppError(error);
    } catch (error) {
      _emitUnknowError();
    }
  }

  bool get _canSignUp =>
      state.name.isNotEmpty &&
      state.email.isNotEmpty &&
      state.password.isNotEmpty;

  Future<void> onForgotPassword() async {
    try {
      await _authService.forgotPassword(state.email);
      return emit(state.copyWith(
        status: BaseStateStatus.success,
        callbackMessage: AppLocalizations.current.forgotPasswordEmailSent,
        name: '',
        email: '',
        password: '',
      ));
    } on AppError catch (error) {
      _emitAppError(error);
    } catch (error) {
      _emitUnknowError();
    }
  }
}

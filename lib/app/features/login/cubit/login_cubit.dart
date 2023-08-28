import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/models/user.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._auth) : super(LoginState(status: BaseStateStatus.initial));

  final Auth _auth;

  void onChangeName(String name) => emit(state.copyWith(name: name));

  void onChangeEmail(String email) => emit(state.copyWith(email: email));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: password));

  void onChangeCurrentPassword(String password) =>
      emit(state.copyWith(currentPassword: password));

  void onChangeLoginMethod() =>
      emit(state.copyWith(isSigningIn: !state.isSigningIn));

  void onChangeShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  void onChangeResetPasswordToken(String? token) =>
      emit(state.copyWith(resetPasswordToken: token));

  Future<void> onSignInWithPassword() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _handleSignInResponse(
        _auth.signInWithPassword(state.email, state.password));
  }

  Future<void> _handleSignInResponse(Future<bool> response) async {
    try {
      final isSignedIn = await response;

      if (isSignedIn) {
        return _emitSuccess('');
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
        currentPassword: '',
      ));

  void _emitUnknowError() => emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
        password: '',
        currentPassword: '',
      ));

  Future<void> onSignInWithGoogle() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _handleSignInResponse(_auth.signInWithGoogle());
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

      await _auth.signUp(user);
      return _emitSuccess(AppLocalizations.current.signUpSuccess);
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

  void _emitSuccess(String message) => emit(state.copyWith(
        status: BaseStateStatus.success,
        callbackMessage: message,
        name: '',
        email: '',
        password: '',
        currentPassword: '',
      ));

  Future<void> onForgotPassword() async {
    try {
      await _auth.forgotPassword(state.email);
      return _emitSuccess(AppLocalizations.current.forgotPasswordEmailSent);
    } on AppError catch (error) {
      _emitAppError(error);
    } catch (error) {
      _emitUnknowError();
    }
  }

  Future<void> onResetPassword() async {
    //TODO: Change AndroidManifest with right domain and create assetLinks.json
    try {
      await _auth.resetPassword(state.password);
      return _emitSuccess(AppLocalizations.current.resetedPassword);
    } on AppError catch (error) {
      _emitAppError(error);
    } catch (error) {
      _emitUnknowError();
    }
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_cubit.dart';
import 'package:kazi/app/core/utils/base_state.dart';

part 'reset_password_state.dart';

class ResetPasswordCubit extends Cubit<ResetPasswordState> with BaseCubit {
  ResetPasswordCubit(this._auth)
      : super(ResetPasswordState(status: BaseStateStatus.initial));

  final Auth _auth;

  void onChangePassword(String password) =>
      emit(state.copyWith(password: password));

  void onChangeCurrentPassword(String password) =>
      emit(state.copyWith(currentPassword: password));

  void onChangeShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  void onChangeResetPasswordToken(String? token) =>
      emit(state.copyWith(resetPasswordToken: token));

  Future<void> onResetPassword(String token) async {
    //TODO: Change AndroidManifest with right domain and create assetLinks.json
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _auth.resetPassword(token, state.password);
      await _auth.signOut();
      return emit(state.copyWith(
        status: BaseStateStatus.success,
        callbackMessage: AppLocalizations.current.resetedPassword,
        password: '',
        currentPassword: '',
      ));
    } on AppError catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: error.message,
        password: '',
        currentPassword: '',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
        password: '',
        currentPassword: '',
      ));
    }
  }

  Future<void> onResetPasswordWithoutToken() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _auth.changePassword(state.currentPassword, state.password);
      await _auth.signOut();
      return emit(state.copyWith(
        status: BaseStateStatus.success,
        callbackMessage: AppLocalizations.current.resetedPassword,
        password: '',
        currentPassword: '',
      ));
    } on AppError catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: error.message,
        password: '',
        currentPassword: '',
      ));
    } catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
        password: '',
        currentPassword: '',
      ));
    }
  }
}

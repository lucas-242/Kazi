import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/utils/base_cubit.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/domain/services/auth_service.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';

part 'sign_in_state.dart';

class SignInCubit extends Cubit<SignInState> with BaseCubit {
  SignInCubit() : super(SignInState(status: BaseStateStatus.initial));

  final _auth = ServiceLocator.get<AuthService>();

  void onChangeEmail(String email) => emit(state.copyWith(email: email));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: password));

  void onChangeShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  Future<void> onSignInWithPassword() async {
    emit(state.copyWith(status: BaseStateStatus.loading));
    await _handleSignInResponse(
        _auth.signInWithPassword(state.email, state.password));
  }

  Future<void> _handleSignInResponse(Future<bool> response) async {
    try {
      final isSignedIn = await response;

      if (isSignedIn) {
        return emit(state.copyWith(
          status: BaseStateStatus.success,
          callbackMessage: '',
          email: '',
          password: '',
        ));
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
    await _handleSignInResponse(_auth.signInWithGoogle());
  }
}

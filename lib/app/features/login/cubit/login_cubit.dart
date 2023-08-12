import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit(this._authService) : super(const LoginState());

  final AuthService _authService;

  void onChangeEmail(String email) => emit(state.copyWith(email: email));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: password));

  void onChangeLoginMethod() =>
      emit(state.copyWith(isSigningIn: !state.isSigningIn));

  void onChangeShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  Future<void> onSignUp() async {}

  Future<void> onSignInWithGoogle() async {
    emit(_loginLoadingState);
    await _handleSignInResponse(_authService.signInWithGoogle());
  }

  LoginLoadingState get _loginLoadingState => LoginLoadingState(
        email: state.email,
        password: state.password,
        isSigningIn: state.isSigningIn,
        showPassword: state.showPassword,
      );

  Future<void> _handleSignInResponse(Future<bool> response) async {
    await response.then((isSignedIn) {
      if (isSignedIn) {
        return emit(const LoginSuccessState());
      }
      return emit(
        LoginErrorState(
          message: AppLocalizations.current.errorUnknowError,
          email: state.email,
          isSigningIn: state.isSigningIn,
        ),
      );
    }).catchError(
      (error) => emit(
        LoginErrorState(
          message: error.toString(),
          email: state.email,
          isSigningIn: state.isSigningIn,
          showPassword: state.showPassword,
        ),
      ),
    );
  }

  Future<void> onSignInWithPassword() async {
    emit(_loginLoadingState);
    await _handleSignInResponse(
        _authService.signInWithPassword(state.email, state.password));
  }
}

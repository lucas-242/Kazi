import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/injector_container.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(const LoginInitialState());

  void onChangeEmail(String email) => emit(
        LoginInitialState(
          email: email,
          password: state.password,
          isSigningIn: state.isSigningIn,
        ),
      );

  void onChangePassword(String password) => emit(
        LoginInitialState(
          email: state.email,
          password: password,
          isSigningIn: state.isSigningIn,
        ),
      );

  void onChangeLoginMethod() => emit(
        LoginInitialState(
          email: state.email,
          password: state.password,
          isSigningIn: !state.isSigningIn,
        ),
      );

  Future<void> onSignUp() async {}

  Future<void> onSignInWithGoogle() async {
    emit(LoginLoadingState(
      email: state.email,
      password: state.password,
      isSigningIn: state.isSigningIn,
    ));
    await _handleSignInResponse(
        serviceLocator<AuthService>().signInWithGoogle());
  }

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
        ),
      ),
    );
  }

  Future<void> onSignInWithPassword() async {
    emit(LoginLoadingState(
      email: state.email,
      password: state.password,
      isSigningIn: !state.isSigningIn,
    ));

    await _handleSignInResponse(serviceLocator<AuthService>()
        .signInWithPassword(state.email, state.password));
  }
}

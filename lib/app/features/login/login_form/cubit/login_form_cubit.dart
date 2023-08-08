import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/injector_container.dart';

part 'login_form_state.dart';

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormInitialState());

  void onChangeEmail(String email) => emit(
        LoginFormInitialState(
          email: email,
          password: state.password,
          isSigningIn: state.isSigningIn,
        ),
      );

  void onChangePassword(String password) => emit(
        LoginFormInitialState(
          email: state.email,
          password: password,
          isSigningIn: state.isSigningIn,
        ),
      );

  void onChangeLoginMethod() => emit(
        LoginFormInitialState(
          email: state.email,
          password: state.password,
          isSigningIn: !state.isSigningIn,
        ),
      );

  Future<void> onSignUp() async {}

  Future<void> onSignInWithGoogle() async {
    emit(LoginFormLoadingState(
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
        return emit(const LoginFormSuccessState());
      }
      return emit(
        LoginFormErrorState(
          message: AppLocalizations.current.errorUnknowError,
          email: state.email,
          isSigningIn: state.isSigningIn,
        ),
      );
    }).catchError(
      (error) => emit(
        LoginFormErrorState(
          message: error.toString(),
          email: state.email,
          isSigningIn: state.isSigningIn,
        ),
      ),
    );
  }

  Future<void> onSignInWithPassword() async {
    emit(LoginFormLoadingState(
      email: state.email,
      password: state.password,
      isSigningIn: !state.isSigningIn,
    ));

    await _handleSignInResponse(serviceLocator<AuthService>()
        .signInWithPassword(state.email, state.password));
  }
}

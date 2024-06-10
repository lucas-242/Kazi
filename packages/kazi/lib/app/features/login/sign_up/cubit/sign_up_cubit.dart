import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/base_cubit.dart';
import 'package:kazi/app/core/utils/base_state.dart';
import 'package:kazi/app/models/user.dart';
import 'package:kazi/service_locator.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> with BaseCubit {
  SignUpCubit() : super(SignUpState(status: BaseStateStatus.initial));

  final _auth = ServiceLocator.get<Auth>();

  void onChangeName(String name) => emit(state.copyWith(name: name));

  void onChangeEmail(String email) => emit(state.copyWith(email: email));

  void onChangePassword(String password) =>
      emit(state.copyWith(password: password));

  void onChangeShowPassword() =>
      emit(state.copyWith(showPassword: !state.showPassword));

  Future<void> onSignUp() async {
    try {
      if (!_canSignUp) {
        return;
      }

      emit(state.copyWith(status: BaseStateStatus.loading));

      final user = User.toCreate(
        name: state.name,
        email: state.email,
        password: state.password,
      );

      await _auth.signUp(user);
      return emit(state.copyWith(
        status: BaseStateStatus.success,
        callbackMessage: AppLocalizations.current.signUpSuccess,
        name: '',
        email: '',
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

  bool get _canSignUp =>
      state.name.isNotEmpty &&
      state.email.isNotEmpty &&
      state.password.isNotEmpty;
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/core/utils/base_cubit.dart';
import 'package:kazi/core/utils/base_state.dart';
import 'package:kazi/domain/services/auth_service.dart';
import 'package:kazi/service_locator.dart';
import 'package:kazi_core/kazi_core.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> with BaseCubit {
  ForgotPasswordCubit()
      : super(ForgotPasswordState(status: BaseStateStatus.initial));

  final _auth = ServiceLocator.get<AuthService>();

  void onChangeEmail(String email) => emit(state.copyWith(email: email));

  Future<void> onForgotPassword() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _auth.forgotPassword(state.email);
      return emit(state.copyWith(status: BaseStateStatus.success));
    } on AppError catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: error.message,
      ));
    } catch (error) {
      emit(state.copyWith(
        status: BaseStateStatus.error,
        callbackMessage: AppLocalizations.current.errorUnknowError,
      ));
    }
  }
}

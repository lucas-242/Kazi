import 'package:bloc/bloc.dart';

import '../errors/errors.dart';
import 'base_state.dart';

mixin BaseCubit<T extends BaseState> on Cubit<T> {
  void onAppError(AppError error) {
    emit(state.copyWith(
      callbackMessage: error.message,
      status: BaseStateStatus.error,
    ) as T);
  }

  void unexpectedError() {
    emit(state.copyWith(
      callbackMessage: 'Erro inesperado',
      status: BaseStateStatus.error,
    ) as T);
  }
}

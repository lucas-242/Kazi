import 'package:bloc/bloc.dart';
import '../l10n/generated/l10n.dart';

import '../errors/errors.dart';
import 'base_state.dart';

mixin BaseCubit<T extends BaseState> on Cubit<T> {
  void onAppError(AppError error) {
    emit(state.copyWith(
      callbackMessage: error.message,
      status: BaseStateStatus.error,
    ) as T);
  }

  void unexpectedError(Object exception) {
    emit(state.copyWith(
      callbackMessage: AppLocalizations.current.unknowError,
      status: BaseStateStatus.error,
    ) as T);
  }
}

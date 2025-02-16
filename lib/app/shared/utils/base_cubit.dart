import 'package:bloc/bloc.dart';
import 'package:kazi/app/shared/utils/log_utils.dart';

import '../errors/errors.dart';
import '../l10n/generated/l10n.dart';
import 'base_state.dart';

mixin BaseCubit<T extends BaseState> on Cubit<T> {
  void onAppError(AppError error) {
    Log.error(error.message);
    emit(state.copyWith(
      callbackMessage: error.message,
      status: BaseStateStatus.error,
    ) as T,);
  }

  void unexpectedError(Object exception) {
    Log.error(exception);
    emit(state.copyWith(
      callbackMessage: AppLocalizations.current.unknowError,
      status: BaseStateStatus.error,
    ) as T,);
  }
}

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:my_services/app/services/auth_service/auth_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';
import 'package:my_services/app/shared/utils/base_cubit.dart';

import '../../../../models/app_user.dart';
import '../../../../models/dropdown_item.dart';
import '../../../../models/enums.dart';
import '../../../errors/errors.dart';
import '../../../utils/base_state.dart';

part 'custom_app_bar_state.dart';

class CustomAppBarCubit extends Cubit<CustomAppBarState> with BaseCubit {
  final AuthService _authService;

  CustomAppBarCubit(this._authService)
      : super(CustomAppBarState(user: _authService.user!));

  void onChangeSelectedMenuItem(DropdownItem item) =>
      emit(state.copyWith(selectedMenuItem: item));

  Future<void> signOut() async {
    try {
      emit(state.copyWith(status: BaseStateStatus.loading));
      await _authService.signOut();
    } on AppError catch (exception) {
      onAppError(exception);
    } catch (exception) {
      unexpectedError(exception);
    }
  }
}

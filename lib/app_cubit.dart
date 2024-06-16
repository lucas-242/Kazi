import 'package:bloc/bloc.dart';
import 'package:kazi/core/routes/routes.dart';

import 'domain/services/auth_service.dart';

class AppCubit extends Cubit<AppPages> {
  AppCubit(this._authService) : super(AppPages.home);
  final AuthService _authService;

  void changePage(AppPages newPage) => emit(newPage);

  Stream<bool> userSignOut() =>
      _authService.userChanges.map((user) => user == null ? true : false);
}

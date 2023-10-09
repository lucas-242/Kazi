import 'package:bloc/bloc.dart';
import 'package:kazi/app/core/routes/routes.dart';

import 'core/auth/auth.dart';

class AppCubit extends Cubit<AppPages> {
  AppCubit(this._authService) : super(AppPages.home);
  final Auth _authService;

  void changePage(AppPages newPage) => emit(newPage);

  Stream<bool> userSignOut() =>
      _authService.userChanges.map((user) => user == null ? true : false);
}

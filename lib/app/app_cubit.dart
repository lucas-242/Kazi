import 'package:bloc/bloc.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:kazi/service_locator.dart';

import 'core/auth/auth.dart';

class AppCubit extends Cubit<AppPages> {
  AppCubit() : super(AppPages.home);
  final _authService = ServiceLocator.get<Auth>();

  void changePage(AppPages newPage) => emit(newPage);

  Stream<bool> userSignOut() =>
      _authService.userChanges.map((user) => user == null ? true : false);
}

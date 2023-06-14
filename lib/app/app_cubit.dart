import 'package:bloc/bloc.dart';
import 'package:kazi/app/models/app_page.dart';

import 'services/auth_service/auth_service.dart';

class AppCubit extends Cubit<AppPage> {
  final AuthService _authService;

  AppCubit(this._authService) : super(AppPage.home);

  void changePage(AppPage newPage) => emit(newPage);

  Stream<bool> userSignOut() =>
      _authService.userChanges().map((user) => user == null ? true : false);
}

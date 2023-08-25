import 'package:bloc/bloc.dart';
import 'package:kazi/app/models/enums/app_page.dart';

import 'core/auth/auth.dart';

class AppCubit extends Cubit<AppPage> {
  AppCubit(this._authService) : super(AppPage.home);
  final Auth _authService;

  void changePage(AppPage newPage) => emit(newPage);

  Stream<bool> userSignOut() =>
      _authService.userChanges.map((user) => user == null ? true : false);
}

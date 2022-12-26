import 'package:bloc/bloc.dart';

import '../../../services/auth_service/auth_service.dart';

class AppCubit extends Cubit<int> {
  final AuthService _authService;

  AppCubit(this._authService) : super(0);

  void changePage(int newPage) => emit(newPage);

  Stream<bool> userSignOut() =>
      _authService.userChanges().map((user) => user == null ? true : false);
}

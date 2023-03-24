import 'package:bloc/bloc.dart';

import 'services/auth_service/auth_service.dart';

class AppCubit extends Cubit<int> {
  final AuthService _authService;

  AppCubit(this._authService) : super(0);

  bool _isAddServicePage = false;
  bool get isAddServicePage => _isAddServicePage;

  void changePage(int newPage) {
    _isAddServicePage = false;
    emit(newPage);
  }

  void changeToAddServicePage() {
    _isAddServicePage = true;
    emit(1);
  }

  Stream<bool> userSignOut() =>
      _authService.userChanges().map((user) => user == null ? true : false);
}

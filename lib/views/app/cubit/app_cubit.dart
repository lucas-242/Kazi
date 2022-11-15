import 'package:bloc/bloc.dart';

class AppCubit extends Cubit<int> {
  AppCubit() : super(0);

  void changePage(int newPage) => emit(newPage);
}

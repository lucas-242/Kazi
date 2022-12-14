import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_services/views/app/app.dart';

void main() {
  late AppCubit cubit;

  setUp(() {
    cubit = AppCubit();
  });

  blocTest(
    'emits AppState(1) when call changePage',
    build: () => cubit,
    act: (cubit) => cubit.changePage(1),
    expect: () => [1],
  );
}

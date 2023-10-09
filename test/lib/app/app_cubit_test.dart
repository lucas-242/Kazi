import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/routes/routes.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_cubit_test.mocks.dart';

@GenerateMocks([Auth])
void main() {
  late AppCubit cubit;
  late MockAuth authService;

  setUp(() {
    authService = MockAuth();
    cubit = AppCubit(authService);

    when(authService.userChanges).thenAnswer((_) => Stream.value(null));
  });

  blocTest(
    'emits AppState(AppPage.Services) when call changePage',
    build: () => cubit,
    act: (cubit) => cubit.changePage(AppPages.services),
    expect: () => [AppPages.services],
  );

  blocTest(
    'Should emit nothing when call userSignOut',
    build: () => cubit,
    act: (cubit) => cubit.userSignOut(),
    expect: () => [],
  );

  test('Should retrun true when call userSignOut', () {
    cubit.userSignOut().listen((userSignOut) {
      expect(userSignOut, isTrue);
    });
  });
}

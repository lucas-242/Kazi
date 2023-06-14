import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/app_cubit.dart';
import 'package:kazi/app/models/app_page.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'app_cubit_test.mocks.dart';

@GenerateMocks([AuthService])
void main() {
  late AppCubit cubit;
  late MockAuthService authService;

  setUp(() {
    authService = MockAuthService();
    cubit = AppCubit(authService);

    when(authService.userChanges()).thenAnswer((_) => Stream.value(null));
  });

  blocTest(
    'emits AppState(AppPage.Services) when call changePage',
    build: () => cubit,
    act: (cubit) => cubit.changePage(AppPage.services),
    expect: () => [AppPage.services],
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

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/domain/connection/kazi_client.dart';
import 'package:kazi/domain/connection/kazi_connection.dart';
import 'package:kazi/domain/repositories/auth_repository.dart';
import 'package:kazi/domain/services/local_storage.dart';
import 'package:kazi/domain/services/time_service.dart';
import 'package:kazi/infra/connection/http_kazi_client.dart';
import 'package:kazi/infra/services/kazi_api_auth_service.dart';
import 'package:kazi/infra/services/local_time_service.dart';
import 'package:kazi/infra/services/shared_preferences_local_storage.dart';
import 'package:kazi_core/kazi_core.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/test_helper.dart';
import '../../../../../utils/test_matchers.dart';
import 'kazi_api_auth_test.mocks.dart';

final _authResponseMock = User.fromSignIn(
    authExpires: DateTime.now().add(const Duration(days: 1)),
    authToken: 'abc123',
    refreshToken: 'abc123Refresh',
    email: 'test@test.com',
    id: 1,
    name: 'Sr. Test',
    userType: UserType.selfEmployed);

@GenerateMocks([KaziConnection, AuthRepository])
void main() {
  late KaziClient client;
  late LocalStorage localStorage;
  late TimeService timeService;
  late MockAuthRepository authRepository;
  late KaziApiAuth authService;

  setUpAll(() {
    TestHelper.loadAppLocalizations();
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    localStorage = SharedPreferencesLocalStorage(sharedPreferences);
    client = HttpKaziClient(localStorage);
    authRepository = MockAuthRepository();
    timeService = LocalTimeService();
    authService = KaziApiAuth(
      authRepository: authRepository,
      localStorage: localStorage,
      timeService: timeService,
      client: client,
    );
  });

  group('Sign in with password', () {
    test('Should return true when sign in with password', (() async {
      when(authRepository.signInWithPassword(any, any))
          .thenAnswer((_) async => _authResponseMock);

      final isSignedIn =
          await authService.signInWithPassword('email', 'password');
      expect(isSignedIn, isTrue);
      expect(authService.user, isNotNull);
    }));

    test('Should throw Error for any error that occurs', (() {
      when(authRepository.signInWithPassword(any, any))
          .thenThrow(ArgumentError());

      expect(
          () => authService.signInWithPassword('email', 'password'),
          ErrorWithMessage<ExternalError>(
              AppLocalizations.current.errorToSignIn));
    }));
  });

  // group('Sign out', () {
  //   test('Should sign out', (() async {
  //     when(authService.user).thenReturn(
  //       AppUser(
  //         name: _authResponseMock.userName,
  //         email: _authResponseMock.userEmail,
  //         uid: _authResponseMock.userId.toString(),
  //       ),
  //     );

  //     expect(authService.user, isNotNull);
  //     await authService.signOut();
  //     expect(authService.user, null);
  //   }));
  // });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/core/auth/kazi_api/kazi_api_auth_service.dart';
import 'package:kazi/app/core/auth/kazi_api/models/user_data.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/data/connection/http/http_kazi_client.dart';
import 'package:kazi/app/data/connection/http/http_kazi_connection.dart';
import 'package:kazi/app/data/connection/kazi_client.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/api_response.dart';
import 'package:kazi/app/models/enums/user_type.dart';
import 'package:kazi/app/services/log_service/log_service.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/test_helper.dart';
import '../../../../../utils/test_matchers.dart';
import 'kazi_api_auth_service_test.mocks.dart';

final _authResponseMock = UserData(
    authExpires: DateTime.now().add(const Duration(days: 1)),
    authToken: 'abc123',
    refreshToken: 'abc123Refresh',
    email: 'test@test.com',
    id: 1,
    name: 'Sr. Test',
    userType: UserType.selfEmployed);

@GenerateMocks([HttpKaziConnection])
void main() {
  late KaziClient client;
  late MockHttpKaziConnection connection;
  late LocalStorage localStorage;
  late TimeService timeService;
  late LogService logService;
  late KaziApiAuthService authService;

  setUpAll(() {
    TestHelper.loadAppLocalizations();
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    localStorage = SharedPreferencesLocalStorage(sharedPreferences);
    client = HttpKaziClient(localStorage);
    connection = MockHttpKaziConnection();
    timeService = LocalTimeService();
    logService = LocalLogService();
    authService = KaziApiAuthService(
        connection: connection,
        localStorage: localStorage,
        timeService: timeService,
        logService: logService,
        client: client);
  });

  group('Sign in with password', () {
    test('Should return true when sign in with password', (() async {
      when(connection.post(any, body: anyNamed('body'))).thenAnswer((_) async =>
          ApiResponse(
              status: 200, body: jsonEncode(_authResponseMock.toJson())));

      final isSignedIn =
          await authService.signInWithPassword('email', 'password');
      expect(isSignedIn, isTrue);
      expect(authService.user, isNotNull);
    }));

    test('Should throw Error for any error that occurs', (() {
      when(connection.post(any, body: anyNamed('body')))
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

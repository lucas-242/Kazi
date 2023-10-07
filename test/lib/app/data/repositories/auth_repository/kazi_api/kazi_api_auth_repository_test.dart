import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/data/repositories/auth_repository/kazi_api/kazi_api_auth_repository.dart';
import 'package:kazi/app/models/api_response.dart';
import 'package:kazi/app/models/enums/user_type.dart';
import 'package:kazi/app/models/user.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../../utils/test_helper.dart';
import '../../../../../../utils/test_matchers.dart';
import 'kazi_api_auth_repository_test.mocks.dart';

final _authResponseMock = User.fromSignIn(
  authExpires: DateTime.now().add(const Duration(days: 1)),
  authToken: 'abc123',
  refreshToken: 'abc123Refresh',
  email: 'test@test.com',
  id: 1,
  name: 'Sr. Test',
  userType: UserType.selfEmployed,
);

@GenerateMocks([KaziConnection])
void main() {
  late KaziApiAuthRepository authRepository;
  late MockKaziConnection connection;

  setUpAll(() {
    TestHelper.loadAppLocalizations();
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    connection = MockKaziConnection();
    authRepository = KaziApiAuthRepository(connection: connection);
  });

  group('Sign in with password', () {
    test('Should return true when sign in with password', (() async {
      when(connection.post(any, body: anyNamed('body'))).thenAnswer((_) async =>
          ApiResponse(
              status: 200, body: jsonEncode(_authResponseMock.toJson())));

      final isSignedIn =
          await authRepository.signInWithPassword('email', 'password');
      expect(isSignedIn, isNotNull);
    }));

    test('Should throw Error for any error that occurs', (() {
      when(connection.post(any, body: anyNamed('body')))
          .thenThrow(ArgumentError());

      expect(
          () => authRepository.signInWithPassword('email', 'password'),
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

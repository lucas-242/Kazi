import 'package:flutter_test/flutter_test.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/api_response.dart';
import 'package:kazi/app/services/api_service/http/http_api_service.dart';
import 'package:kazi/app/services/auth_service/kazi_api/kazi_api_auth_service.dart';
import 'package:kazi/app/services/auth_service/kazi_api/models/auth_response.dart';
import 'package:kazi/app/services/time_service/local/local_time_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../utils/test_helper.dart';
import '../../../../../utils/test_matchers.dart';
import 'kazi_api_auth_service_test.mocks.dart';

// class MockApiService extends Mock implements HttpApiService {
//   MockApiService({this.isSignedIn = false});
//   final bool isSignedIn;

//   @override
//   Future<ApiResponse> get(
//     String? url, {
//     Map<String, String>? parameters,
//   });
//   @override
//   Future<ApiResponse> post(
//     String? url, {
//     Object? body,
//     Map<String, String>? parameters,
//   });
//   @override
//   Future<ApiResponse> put(
//     String? url, {
//     Object? body,
//     Map<String, String>? parameters,
//   });
//   @override
//   Future<ApiResponse> patch(
//     String? url, {
//     Object? body,
//     Map<String, String>? parameters,
//   });
//   @override
//   Future<ApiResponse> delete(
//     String? url, {
//     Object? body,
//     Map<String, String>? parameters,
//   });
// }

final _authResponseMock = AuthResponse(
  authExpires:
      DateTime.now().add(const Duration(days: 1)).millisecondsSinceEpoch,
  authToken: 'abc123',
  refreshToken: 'abc123Refresh',
  userEmail: 'test@test.com',
  userId: 1,
  userName: 'Sr. Test',
);

@GenerateMocks([HttpApiService])
void main() {
  late MockHttpApiService apiService;
  late LocalStorage localStorage;
  late TimeService timeService;
  late KaziApiAuthService authService;

  setUpAll(() {
    TestHelper.loadAppLocalizations();
  });

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    final sharedPreferences = await SharedPreferences.getInstance();
    localStorage = SharedPreferencesLocalStorage(sharedPreferences);
    apiService = MockHttpApiService();
    timeService = LocalTimeService();
    authService = KaziApiAuthService(
      apiService: apiService,
      localStorage: localStorage,
      timeService: timeService,
    );
  });

  group('Sign in with password', () {
    test('Should return true when sign in with password', (() async {
      when(apiService.post(any, body: anyNamed('body'))).thenAnswer((_) async =>
          ApiResponse(status: 200, body: _authResponseMock.toJson()));

      final isSignedIn =
          await authService.signInWithPassword('email', 'password');
      expect(isSignedIn, isTrue);
      expect(authService.user, isNotNull);
    }));

    test('Should throw Error for any error that occurs', (() async {
      when(apiService.post(any, body: anyNamed('body'))).thenAnswer((_) async =>
          ApiResponse(status: 500, body: _authResponseMock.toJson()));

      when(apiService.handleResponse(any)).thenThrow(ExternalError('error'));

      expect(authService.signInWithPassword('email', 'password'),
          ErrorWithMessage<AppError>('error'));
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

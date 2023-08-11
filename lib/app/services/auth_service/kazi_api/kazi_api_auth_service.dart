import 'package:kazi/app/core/connection/kazi_connection.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/app_user.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/services/auth_service/kazi_api/models/auth_response.dart';
import 'package:kazi/app/services/auth_service/kazi_api/models/user_data.dart';
import 'package:kazi/app/services/time_service/time_service.dart';

final class KaziApiAuthService extends AuthService {
  KaziApiAuthService({
    required KaziConnection connection,
    required LocalStorage localStorage,
    required TimeService timeService,
  })  : _connection = connection,
        _localStorage = localStorage,
        _timeService = timeService;

  final String url = '${Environment.instance.kaziApiUrl}auth';
  final KaziConnection _connection;
  final LocalStorage _localStorage;
  final TimeService _timeService;

  UserData? _userData;

  Future<void> refreshSession({String? refreshToken}) async {
    try {
      final response = await _connection.post('refreshToken',
          body: refreshToken ?? _userData?.refreshToken);

      _connection.handleResponse(response);

      final authResponse = AuthResponse.fromJson(response.json);

      _setUserData(authResponse);
      _setUser(authResponse);
      await _saveUserDataInLocalStorage();
    } catch (error) {
      signOut();
      rethrow;
    }
  }

  void _setUserData(AuthResponse data) {
    _userData = UserData(
      authExpireDate:
          _timeService.now.add(Duration(milliseconds: data.authExpires)),
      authExpireMiliseconds: data.authExpires,
      authToken: data.authToken,
      refreshToken: data.refreshToken,
      userEmail: data.userEmail,
      userId: data.userId,
      userName: data.userName,
    );
  }

  void _setUser(AuthResponse data) {
    user = AppUser(
      email: data.userEmail,
      uid: data.userId.toString(),
      name: data.userName,
    );
  }

  Future<void> _saveUserDataInLocalStorage() => _localStorage.set<String>(
      AppKeys.userData, _userData!.toJson().toString());

  @override
  Future<void> signOut() async {
    _userData = null;
    user = null;
    await _localStorage.remove(AppKeys.userData);
  }

  @override
  Future<bool> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signInWithPassword(String email, String password) async {
    final response = await _connection.post(
      url,
      body: {'email': email, 'password': password},
    );
    _connection.handleResponse(response);

    final authResponse = AuthResponse.fromJson(response.json);
    _setUserData(authResponse);
    _setUser(authResponse);
    await _saveUserDataInLocalStorage();
    return true;
  }

  @override
  Stream<AppUser?> userChanges() async* {
    try {
      if (_isTokenExpired) {
        await refreshSession();
      }

      yield user;
    } catch (error) {
      yield null;
    }
  }

  bool get _isTokenExpired =>
      _userData!.authExpireDate.isBefore(_timeService.now);
}

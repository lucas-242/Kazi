import 'dart:async';
import 'dart:convert';

import 'package:kazi/app/core/connection/kazi_connection.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/models/app_user.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/services/auth_service/kazi_api/models/user_data.dart';
import 'package:kazi/app/services/log_service/log_service.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:rxdart/rxdart.dart';

final class KaziApiAuthService extends AuthService {
  KaziApiAuthService({
    required KaziConnection connection,
    required LocalStorage localStorage,
    required TimeService timeService,
    required LogService logService,
  })  : _connection = connection,
        _localStorage = localStorage,
        _timeService = timeService,
        _logService = logService {
    _tryAutoSignIn();
  }

  final String url = '${Environment.instance.kaziApiUrl}auth';
  final KaziConnection _connection;
  final LocalStorage _localStorage;
  final TimeService _timeService;
  final LogService _logService;

  UserData? _userData;

  final _userController = BehaviorSubject<AppUser?>();

  @override
  Stream<AppUser?> get userChanges => _userController.stream;

  Future<void> _tryAutoSignIn() async {
    try {
      final userData = _getUserData();

      if (userData == null) {
        _userController.sink.add(null);
        return;
      }

      _userData = userData;
      user = AppUser.fromSignIn(
        email: _userData!.email,
        uid: _userData!.id.toString(),
        name: _userData!.name,
        userType: _userData!.userType,
      );
      if (_isTokenExpired) {
        return await refreshSession(_userData!.refreshToken);
      }

      _userController.sink.add(user);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      await signOut();
      throw ExternalError(AppLocalizations.current.errorUnknowError);
    }
  }

  bool get _isTokenExpired =>
      _userData!.authExpiresDate.isBefore(_timeService.now);

  UserData? _getUserData() {
    final stringfyUser = _localStorage.get<String>(AppKeys.userData);
    if (stringfyUser == null) {
      return null;
    }
    final response = UserData.fromJson(jsonDecode(stringfyUser));
    return response;
  }

  Future<void> refreshSession(String? refreshToken) async {
    try {
      final response = await _connection.post('refreshToken',
          body: refreshToken ?? _userData?.refreshToken);

      _connection.handleResponse(response);

      final authResponse = UserData.fromJson(response.json);

      _setUserData(authResponse);
      _setUser(authResponse);
      await _saveUserDataInLocalStorage();
      _userController.sink.add(user);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      await signOut();
      throw ExternalError(AppLocalizations.current.errorUnknowError);
    }
  }

  void _setUserData(UserData data) {
    _userData = UserData(
      authExpiresDate:
          _timeService.now.add(Duration(milliseconds: data.authExpires)),
      authExpires: data.authExpires,
      authToken: data.authToken,
      refreshToken: data.refreshToken,
      email: data.email,
      id: data.id,
      name: data.name,
      userType: data.userType,
    );
  }

  void _setUser(UserData data) {
    user = AppUser.fromSignIn(
      email: data.email,
      uid: data.id.toString(),
      name: data.name,
      userType: data.userType,
    );
  }

  Future<void> _saveUserDataInLocalStorage() => _localStorage.set<String>(
      AppKeys.userData, jsonEncode(_userData!.toJson()));

  @override
  Future<void> signOut() async {
    _userData = null;
    user = null;
    _userController.sink.add(user);
    await _localStorage.remove(AppKeys.userData);
  }

  @override
  Future<bool> signInWithGoogle() {
    throw UnimplementedError();
  }

  @override
  Future<bool> signInWithPassword(String email, String password) async {
    try {
      final response = await _connection.post(
        '$url/authenticateByEmail',
        body: {'email': email, 'password': password},
      );
      _connection.handleResponse(response);

      final authResponse = UserData.fromJson(response.json);
      _setUserData(authResponse);
      _setUser(authResponse);
      await _saveUserDataInLocalStorage();
      _userController.sink.add(user);
      return true;
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      throw ExternalError(AppLocalizations.current.errorToSignIn);
    }
  }

  @override
  Future<void> signUp(AppUser user) async {
    try {
      //TODO: Change url to auth/signup
      final response = await _connection.post(
        '${Environment.instance.kaziApiUrl}user/',
        body: user.toJson(),
      );
      _connection.handleResponse(response);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      throw ExternalError(AppLocalizations.current.errorToSignUp);
    }
  }
}

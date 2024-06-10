import 'dart:async';
import 'dart:convert';

import 'package:kazi/app/core/auth/auth.dart';
import 'package:kazi/app/core/constants/app_keys.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/core/utils/log_utils.dart';
import 'package:kazi/app/data/connection/kazi_client.dart';
import 'package:kazi/app/data/local_storage/local_storage.dart';
import 'package:kazi/app/data/repositories/auth_repository/auth_repository.dart';
import 'package:kazi/app/models/user.dart';
import 'package:kazi/app/services/time_service/time_service.dart';
import 'package:rxdart/rxdart.dart';

final class KaziApiAuth extends Auth {
  KaziApiAuth({
    required AuthRepository authRepository,
    required LocalStorage localStorage,
    required TimeService timeService,
    required KaziClient client,
  })  : _authRepository = authRepository,
        _localStorage = localStorage,
        _timeService = timeService,
        _client = client {
    _tryAutoSignIn();
  }

  final AuthRepository _authRepository;
  final LocalStorage _localStorage;
  final TimeService _timeService;
  final KaziClient _client;

  final _userController = BehaviorSubject<User?>();

  bool get _isTokenExpired =>
      user!.authExpires.isBefore(_timeService.nowWithTime);

  @override
  Stream<User?> get userChanges => _userController.stream;

  Future<void> _tryAutoSignIn() async {
    try {
      final response = _getUserFromStorage();

      if (response == null) {
        _userController.sink.add(null);
        return;
      }

      user = response;
      if (_isTokenExpired) {
        return await refreshSession(user!.refreshToken);
      }

      _userController.sink.add(response);
    } catch (error, trace) {
      Log.error(error, trace);
      await signOut();
      throw ExternalError(AppLocalizations.current.errorUnknowError);
    }
  }

  User? _getUserFromStorage() {
    final stringfyUser = _localStorage.get<String>(AppKeys.userData);
    if (stringfyUser == null) {
      return null;
    }
    final response = User.fromJson(jsonDecode(stringfyUser));
    return response;
  }

  Future<void> refreshSession(String? refreshToken) async {
    try {
      final response = await _authRepository.refreshSession(refreshToken);
      _setUser(response);
      await _saveUserInLocalStorage();
      _userController.sink.add(user);
    } catch (error, trace) {
      Log.error(error, trace);
      await signOut();
      throw ExternalError(AppLocalizations.current.errorUnknowError);
    }
  }

  void _setUser(User data) {
    user = User.fromSignIn(
      authExpires: data.authExpires,
      authToken: data.authToken,
      refreshToken: data.refreshToken,
      email: data.email,
      id: data.id,
      name: data.name,
      userType: data.userType,
    );
  }

  Future<void> _saveUserInLocalStorage() =>
      _localStorage.set<String>(AppKeys.userData, jsonEncode(user!.toJson()));

  @override
  Future<void> signOut() async {
    user = null;
    _userController.sink.add(user);
    _client.reset();
    await _localStorage.remove(AppKeys.userData);
    await _localStorage.remove(AppKeys.showOnboardingStorage);
  }

  @override
  Future<bool> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<bool> signInWithPassword(String email, String password) async {
    try {
      final response =
          await _authRepository.signInWithPassword(email, password);

      _setUser(response);
      await _saveUserInLocalStorage();
      _userController.sink.add(user);
      return true;
    } catch (error, trace) {
      Log.error(error, trace);
      throw ExternalError(AppLocalizations.current.errorToSignIn);
    }
  }

  @override
  Future<void> signUp(User user) async => _authRepository.signUp(user);

  @override
  Future<void> forgotPassword(String email) async =>
      _authRepository.forgotPassword(email);

  @override
  Future<void> resetPassword(String token, String newPassword) async =>
      _authRepository.resetPassword(token, newPassword);

  @override
  Future<void> changePassword(
          String currentPassword, String newPassword) async =>
      _authRepository.changePassword(currentPassword, newPassword);
}

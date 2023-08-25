import 'dart:async';

import 'package:kazi/app/core/environment/environment.dart';
import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';
import 'package:kazi/app/data/connection/kazi_connection.dart';
import 'package:kazi/app/data/repositories/auth_repository/auth_repository.dart';
import 'package:kazi/app/models/user.dart';
import 'package:kazi/app/services/log_service/log_service.dart';

final class KaziApiAuthRepository extends AuthRepository {
  KaziApiAuthRepository({
    required KaziConnection connection,
    required LogService logService,
  })  : _connection = connection,
        _logService = logService;

  final String url = '${Environment.instance.kaziApiUrl}auth';
  final KaziConnection _connection;
  final LogService _logService;

  @override
  Future<User> refreshSession(String? refreshToken) async {
    try {
      final response =
          await _connection.post('refreshToken', body: refreshToken);

      _connection.handleResponse(response);

      return User.fromJson(response.json);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      throw ExternalError(AppLocalizations.current.errorUnknowError);
    }
  }

  @override
  Future<User> signInWithGoogle() {
    // TODO: implement signInWithGoogle
    throw UnimplementedError();
  }

  @override
  Future<User> signInWithPassword(String email, String password) async {
    try {
      final response = await _connection.post(
        '$url/authenticateByEmail',
        body: {'email': email, 'password': password},
      );
      _connection.handleResponse(response);

      return User.fromJson(response.json);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      throw ExternalError(AppLocalizations.current.errorToSignIn);
    }
  }

  @override
  Future<void> signUp(User user) async {
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

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final response = await _connection.post(
        '${Environment.instance.kaziApiUrl}/forgot-password',
        body: email,
      );
      _connection.handleResponse(response);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      throw ExternalError(AppLocalizations.current.errorToSendEmail);
    }
  }

  @override
  Future<void> resetPassword(String password) async {
    try {
      final response = await _connection.post(
        '${Environment.instance.kaziApiUrl}/reset-password',
        body: password,
      );
      _connection.handleResponse(response);
    } catch (error, trace) {
      _logService.error(error: error, stackTrace: trace);
      throw ExternalError(AppLocalizations.current.errorToResetPassword);
    }
  }
}

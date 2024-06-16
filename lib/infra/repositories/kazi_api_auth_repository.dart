import 'dart:async';

import 'package:kazi/core/environment/environment.dart';
import 'package:kazi/core/l10n/generated/l10n.dart';
import 'package:kazi/domain/connection/kazi_connection.dart';
import 'package:kazi/domain/repositories/auth_repository.dart';
import 'package:kazi_core/kazi_core.dart';

final class KaziApiAuthRepository implements AuthRepository {
  KaziApiAuthRepository({
    required KaziConnection connection,
  }) : _connection = connection;

  final String url = '${Environment.instance.kaziApiUrl}auth';
  final KaziConnection _connection;

  @override
  Future<User> refreshSession(String? refreshToken) async {
    try {
      final response =
          await _connection.post('refreshToken', body: refreshToken);

      response.handleStatus();

      return User.fromJson(response.json);
    } catch (error, trace) {
      Log.error(error, trace);
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
      response.handleStatus();

      return User.fromJson(response.json);
    } catch (error, trace) {
      Log.error(error, trace);
      throw ExternalError(AppLocalizations.current.errorToSignIn);
    }
  }

  @override
  Future<void> signUp(User user) async {
    try {
      final response = await _connection.post(
        '$url/signup/',
        body: user.toJson(),
      );
      response.handleStatus();
    } catch (error, trace) {
      Log.error(error, trace);
      throw ExternalError(AppLocalizations.current.errorToSignUp);
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    try {
      final response =
          await _connection.get('$url/sendResetPasswordLink/$email');
      response.handleStatus();
    } catch (error, trace) {
      Log.error(error, trace);
      throw ExternalError(AppLocalizations.current.errorToSendEmail);
    }
  }

  @override
  Future<void> changePassword(
    String currentPassword,
    String newPassword,
  ) async {
    try {
      final response = await _connection.post(
        '$url/changePassword',
        body: {
          'currentPassword': currentPassword,
          'newPassword': newPassword,
        },
      );
      response.handleStatus();
    } catch (error, trace) {
      Log.error(error, trace);
      throw ExternalError(AppLocalizations.current.errorToResetPassword);
    }
  }

  @override
  Future<void> resetPassword(String token, String newPassword) async {
    try {
      final response = await _connection.post(
        '$url/changePassword',
        body: {
          'token': token,
          'newPassword': newPassword,
        },
      );
      response.handleStatus();
    } catch (error, trace) {
      Log.error(error, trace);
      throw ExternalError(AppLocalizations.current.errorToResetPassword);
    }
  }
}

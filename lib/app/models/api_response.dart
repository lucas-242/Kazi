import 'dart:convert';

import 'package:kazi/app/core/errors/errors.dart';
import 'package:kazi/app/core/l10n/generated/l10n.dart';

class ApiResponse {
  ApiResponse({
    required this.status,
    this.message,
    required this.body,
  });

  int status;
  String? message;
  String body;

  dynamic get json => jsonDecode(body);

  void handleStatus({
    Function? status408,
    Function? status404,
    Function? status403,
    Function? status401,
    Function? status400,
    Function? status500,
  }) {
    switch (status) {
      case 404:
        {
          if (status404 != null) {
            status404();
          }
          throw ClientError(message ?? AppLocalizations.current.errorNotFound);
        }
      case 403:
        {
          if (status403 != null) {
            status403();
          }
          throw ClientError(message ?? 'Access denied');
        }
      case 401:
        {
          if (status401 != null) {
            status401();
          }
          throw ClientError(message ?? 'Token is Expired');
        }
      case 400:
        {
          if (status400 != null) {
            status400();
          }
          throw ClientError(
              message ?? AppLocalizations.current.errorUnknowError);
        }
      case 408:
        {
          if (status408 != null) {
            status408();
          }
          throw TimeoutError(message ?? AppLocalizations.current.errorTimeout);
        }
      case 500:
        {
          if (status500 != null) {
            status500();
          }
          throw ExternalError(
              message ?? AppLocalizations.current.errorUnknowError);
        }
    }
  }
}

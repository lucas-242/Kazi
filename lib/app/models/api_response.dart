import 'dart:convert';

import 'package:kazi/app/core/errors/errors.dart';

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
    Function? status403,
    Function? status401,
    Function? status400,
    Function? status500,
  }) {
    switch (status) {
      case 403:
        {
          if (status403 != null) {
            status403();
          }
          throw ClientError(message ?? '');
        }
      case 401:
        {
          if (status401 != null) {
            status401();
          }
          throw ClientError(message ?? '');
        }
      case 400:
        {
          if (status400 != null) {
            status400();
          }
          throw ClientError(message ?? '');
        }
      case 500:
        {
          if (status500 != null) {
            status500();
          }
          throw ExternalError(message ?? '');
        }
    }
  }
}

import 'dart:developer' as developer;

import 'package:kazi/app/shared/errors/errors.dart';

enum LogColor { red, blue, green, yellow }

abstract class Log {
  static const _logColors = <LogColor, String>{
    LogColor.red: '31',
    LogColor.blue: '32',
    LogColor.yellow: '33',
    LogColor.green: '35',
  };

  static void navigation(String message) {
    _log(
      message: message,
      color: LogColor.blue,
      type: 'Navigation',
    );
  }

  static void info(String message) {
    _log(
      message: message,
      color: LogColor.yellow,
      type: 'Info',
    );
  }

  static void flow(String message) {
    _log(
      message: message,
      color: LogColor.green,
      type: 'Flow',
    );
  }

  static void error(
    Object? error, [
    StackTrace? stackTrace,
    String? message,
  ]) {
    _log(
      type: 'Error',
      message: message,
      error: error,
      stackTrace: stackTrace,
    );
  }

  static void _log({
    String? message,
    String type = 'Unknown',
    LogColor color = LogColor.red,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logEmptyLine(type, color);
    _logMessage(message, type, color);
    _logError(error, type, color);
    _logStackTrace(stackTrace, type, color);
    _logEmptyLine(type, color);
  }

  static void _logEmptyLine(String type, LogColor color) {
    developer.log(
      '''\x1B[${_logColors[color]}m.---------------------------------------------------------------\x1B[0m''',
      name: type,
    );
  }

  static void _logMessage(String? message, String type, LogColor color) {
    if (message != null) {
      developer.log(
        '''\x1B[${_logColors[color]}m. Message: $message\x1B[0m''',
        name: type,
      );
    }
  }

  static void _logError(Object? error, String type, LogColor color) {
    if (error != null) {
      if (error is AppError) {
        _logAppError(error, type, color);
      } else {
        _logGenericError(error.toString(), type, color);
      }
    }
  }

  static void _logAppError(AppError error, String type, LogColor color) {
    developer.log(
      '''\x1B[${_logColors[color]}m.\x1B[0m''',
      name: type,
    );

    _logGenericError(error.message, type, color);
  }

  static void _logGenericError(String error, String type, LogColor color) {
    developer.log(
      '''\x1B[${_logColors[color]}m. Error: $error \x1B[0m''',
      name: type,
    );
  }

  static void _logStackTrace(
    StackTrace? stackTrace,
    String type,
    LogColor color,
  ) {
    if (stackTrace != null) {
      developer.log(
        '''\x1B[${_logColors[color]}m. StackTrace: ${stackTrace.toString()} \x1B[0m''',
        name: type,
      );
    }
  }
}

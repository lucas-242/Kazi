abstract class AppError implements Exception {
  String message;
  String trace;

  AppError(this.message, this.trace);
}

class ExternalError extends AppError {
  ExternalError(super.message, super.trace);
}

class InternalError extends AppError {
  InternalError(super.message, super.trace);
}

import 'package:kazi/app/shared/errors/errors.dart';
import 'package:kazi/app/shared/l10n/generated/l10n.dart';

/// {@template firebase_sign_in_error}
/// Thrown during the login process if a failure occurs.
/// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithCredential.html
/// {@endtemplate}
class FirebaseSignInError extends ExternalError {
  /// {@macro firebase_sign_in_error}
  FirebaseSignInError({String? message, String? trace})
      : super(message ?? AppLocalizations.current.unknowError, trace: trace);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory FirebaseSignInError.fromCode(String code, [String? trace]) {
    switch (code) {
      case 'account-exists-with-different-credential:':
        return FirebaseSignInError(
          message: AppLocalizations.current.thereIsAnotherAccount,
          trace: trace,
        );
      case 'invalid-credential':
        return FirebaseSignInError(
          message: AppLocalizations.current.credentialIsInvalid,
          trace: trace,
        );
      case 'invalid-verification-code':
        return FirebaseSignInError(
          message: AppLocalizations.current.verificationCodeIsInvalid,
          trace: trace,
        );
      case 'invalid-verification-id':
        return FirebaseSignInError(
          message: AppLocalizations.current.verificationIdIsInvalid,
          trace: trace,
        );
      case 'operation-not-allowed':
        return FirebaseSignInError(
          message: AppLocalizations.current.methodNotAllowed,
          trace: trace,
        );
      case 'invalid-email':
        return FirebaseSignInError(
          message: AppLocalizations.current.emailIsInvalid,
          trace: trace,
        );
      case 'user-disabled':
        return FirebaseSignInError(
          message: AppLocalizations.current.userHasBeenDisabled,
          trace: trace,
        );
      case 'user-not-found':
        return FirebaseSignInError(
          message: AppLocalizations.current.emailWasNotFound,
          trace: trace,
        );
      case 'wrong-password':
        return FirebaseSignInError(
          message: AppLocalizations.current.incorrectEmailOrPassword,
          trace: trace,
        );
      default:
        return FirebaseSignInError(trace: trace);
    }
  }
}

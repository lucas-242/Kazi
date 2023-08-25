import 'package:kazi/app/models/app_user.dart';

abstract class AuthRepository {
  Future<AppUser> signInWithPassword(String email, String password);

  Future<AppUser> signInWithGoogle();

  Future<void> signUp(AppUser user);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String password);
}

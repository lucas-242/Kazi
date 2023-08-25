import 'package:kazi/app/models/app_user.dart';

abstract class Auth {
  AppUser? user;

  Future<bool> signInWithPassword(String email, String password);

  Future<bool> signInWithGoogle();

  Future<void> signOut();

  Future<void> signUp(AppUser user);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String password);

  Stream<AppUser?> get userChanges;
}

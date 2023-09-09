import 'package:kazi/app/models/user.dart';

abstract class Auth {
  User? user;

  Future<bool> signInWithPassword(String email, String password);

  Future<bool> signInWithGoogle();

  Future<void> signOut();

  Future<void> signUp(User user);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String token, String newPassword);

  Future<void> changePassword(String currentPassword, String newPassword);

  Stream<User?> get userChanges;
}

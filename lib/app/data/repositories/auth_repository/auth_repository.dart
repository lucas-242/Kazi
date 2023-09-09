import 'package:kazi/app/models/user.dart';

abstract class AuthRepository {
  Future<User> signInWithPassword(String email, String password);

  Future<User> signInWithGoogle();

  Future<void> signUp(User user);

  Future<User> refreshSession(String? refreshToken);

  Future<void> forgotPassword(String email);

  Future<void> resetPassword(String token, String newPassword);

  Future<void> changePassword(String currentPassword, String newPassword);
}

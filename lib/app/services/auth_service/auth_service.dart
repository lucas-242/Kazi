import 'package:kazi/app/models/app_user.dart';

abstract class AuthService {
  AppUser? user;

  Future<bool> signInWithPassword();

  Future<bool> signInWithGoogle();

  Future<void> signOut();

  Stream<AppUser?> userChanges();
}

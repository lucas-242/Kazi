import 'package:my_services/app/models/app_user.dart';

abstract class AuthService {
  AppUser? user;

  Future<bool> signInWithGoogle();

  Future<void> signOut();

  Stream<AppUser?> userChanges();
}

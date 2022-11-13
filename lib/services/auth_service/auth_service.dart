import 'package:my_services/models/app_user.dart';

abstract class AuthService {
  AppUser? user;

  Future<bool> signInWithGoogle();

  Future<bool> signOut();

  Stream<AppUser?> userChanges();
}

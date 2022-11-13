import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_services/models/app_user.dart';

extension FirebaseUserExtension on User {
  AppUser toAppUser() {
    return AppUser(
      uid: uid,
      email: email ?? '',
      name: displayName ?? email ?? '',
      photoUrl: photoURL,
    );
  }
}

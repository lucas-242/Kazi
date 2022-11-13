import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../models/app_user.dart';
import '../../auth_service/auth_service.dart';
import '../../../shared/extensions/extensions.dart';

class AuthServiceFirebaseImpl extends AuthService {
  @override
  Future<bool> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return false;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((response) {
      user = response.user?.toAppUser();
      return true;
    }).catchError((error) {
      user = null;
      return false;
    });
  }

  @override
  Future<bool> signOut() async {
    return await GoogleSignIn().signOut().then((value) async {
      return await FirebaseAuth.instance.signOut().then((value) {
        user = null;
        return true;
      }).catchError((error) => false);
    }).catchError((error) => false);
  }

  @override
  Stream<AppUser?> userChanges() {
    return FirebaseAuth.instance.userChanges().map((user) => user?.toAppUser());
  }
}

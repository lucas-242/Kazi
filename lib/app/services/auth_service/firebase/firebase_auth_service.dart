import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:kazi/app/models/app_user.dart';
import 'package:kazi/app/services/auth_service/auth_service.dart';
import 'package:kazi/app/core/extensions/extensions.dart';

import 'errors/firebase_sign_in_error.dart';

final class FirebaseAuthService extends AuthService {
  FirebaseAuthService({
    GoogleSignIn? googleSignIn,
    FirebaseAuth? firebaseAuth,
    AppUser? user,
  })  : googleSignIn = googleSignIn ?? GoogleSignIn(),
        firebaseAuth = firebaseAuth ?? FirebaseAuth.instance {
    this.user = user;
  }
  final GoogleSignIn googleSignIn;
  final FirebaseAuth firebaseAuth;

  @override
  Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

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

      final response = await firebaseAuth.signInWithCredential(credential);
      user = response.user?.toAppUser();
      return true;
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInError.fromCode(
          error.code, error.stackTrace?.toString());
    } catch (error) {
      throw FirebaseSignInError();
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await googleSignIn.signOut();
      await firebaseAuth.signOut();
      user = null;
    } on FirebaseAuthException catch (error) {
      throw FirebaseSignInError.fromCode(
          error.code, error.stackTrace?.toString());
    } catch (error) {
      throw FirebaseSignInError();
    }
  }

  @override
  Stream<AppUser?> userChanges() =>
      firebaseAuth.userChanges().map((user) => user?.toAppUser());

  @override
  Future<bool> signInWithPassword(String email, String password) {
    throw UnimplementedError();
  }
}

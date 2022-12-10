import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/services/auth_service/firebase/firebase_auth_service.dart';
import 'package:my_services/services/auth_service/firebase/errors/firebase_sign_in_error.dart';
import 'package:my_services/shared/l10n/generated/l10n.dart';

import '../../mocks/mocks.dart';
import '../../test_helper.dart';
import 'auth_service_firebase_impl_test.mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  final bool isSignedIn;

  MockFirebaseAuth({this.isSignedIn = false});

  @override
  Future<UserCredential> signInWithCredential(AuthCredential? credential) =>
      Future.value(userCredential);

  @override
  Future<UserCredential> signOut() => Future.value(userCredential);

  @override
  User? get currentUser => isSignedIn ? user : null;

  @override
  Stream<User?> userChanges() {
    return Stream.value(currentUser);
  }
}

class MockUser extends Mock implements User {
  @override
  bool get isAnonymous => false;

  @override
  String get uid => appUser.uid;

  @override
  String? get email => appUser.email;

  @override
  String? get displayName => appUser.name;
}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {
  @override
  String? get accessToken => 'abc123';

  @override
  String? get idToken => 'abc123';
}

final userCredential = MockUserCredential();
final user = MockUser();

@GenerateMocks([GoogleSignIn, GoogleSignInAccount, UserCredential])
void main() {
  late MockGoogleSignIn googleSignIn;
  late MockGoogleSignInAccount googleSignInAccount;
  late MockGoogleSignInAuthentication googleSignInAuthentication;
  late FirebaseAuthService authService;
  late MockFirebaseAuth firebaseAuth;

  setUpAll(() {
    TestHelper.loadAppLocalizations();
  });

  setUp(() {
    googleSignIn = MockGoogleSignIn();
    googleSignInAccount = MockGoogleSignInAccount();
    googleSignInAuthentication = MockGoogleSignInAuthentication();
    firebaseAuth = MockFirebaseAuth();
    authService = FirebaseAuthService(
      googleSignIn: googleSignIn,
      firebaseAuth: firebaseAuth,
    );
  });

  group('Sign in', () {
    test('Should return true when sign in with google', (() async {
      when(googleSignIn.signIn()).thenAnswer((_) async => googleSignInAccount);

      when(googleSignInAccount.authentication)
          .thenAnswer((_) async => googleSignInAuthentication);

      when(userCredential.user).thenReturn(user);

      final isSignedIn = await authService.signInWithGoogle();
      expect(isSignedIn, isTrue);
    }));

    test('Should return false when dismiss sign in with google popup',
        (() async {
      when(googleSignIn.signIn()).thenAnswer((_) async => null);

      final isSignedIn = await authService.signInWithGoogle();
      expect(isSignedIn, isFalse);
    }));

    test(
        'Should throws FirebaseSignInError with invalid credential message to sign in with google',
        (() async {
      when(googleSignIn.signIn())
          .thenThrow(FirebaseAuthException(code: 'invalid-credential'));

      expect(authService.signInWithGoogle, throwsException);
      throwsA(predicate((e) =>
          e is FirebaseSignInError &&
          e.message == AppLocalizations.current.credentialIsInvalid));
    }));
  });

  group('Sign out', () {
    test('Should sign out with google', (() async {
      firebaseAuth = MockFirebaseAuth(isSignedIn: true);
      authService = FirebaseAuthService(
        googleSignIn: googleSignIn,
        firebaseAuth: firebaseAuth,
        user: appUser,
      );

      expect(authService.user, isNotNull);

      when(googleSignIn.signOut()).thenAnswer((_) async => null);
      await authService.signOut();

      expect(authService.user, null);
    }));

    test(
        'Should throws FirebaseSignInError with unknow error message to sign out with google',
        (() async {
      when(googleSignIn.signOut()).thenThrow(FirebaseAuthException(code: ''));

      expect(authService.signInWithGoogle, throwsException);
      throwsA(predicate((e) =>
          e is FirebaseSignInError &&
          e.message == AppLocalizations.current.unknowError));
    }));
  });

  group('Listen user changes', () {
    test('Should return null when user is not signed in', () async {
      final result = authService.userChanges();

      result.listen((event) {
        expect(event, isNull);
      });
    });

    test('Should return user', () {
      firebaseAuth = MockFirebaseAuth(isSignedIn: true);
      authService = FirebaseAuthService(
        googleSignIn: googleSignIn,
        firebaseAuth: firebaseAuth,
        user: appUser,
      );
      final result = authService.userChanges();

      result.listen((event) {
        expect(event, isNotNull);
        expect(event!.uid, user.uid);
      });
    });
  });
}

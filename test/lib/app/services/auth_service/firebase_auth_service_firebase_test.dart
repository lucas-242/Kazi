import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:my_services/app/services/auth_service/firebase/errors/firebase_sign_in_error.dart';
import 'package:my_services/app/services/auth_service/firebase/firebase_auth_service.dart';
import 'package:my_services/app/shared/l10n/generated/l10n.dart';

import '../../../../mocks/mocks.dart';
import '../../../../utils/test_helper.dart';
import '../../../../utils/test_matchers.dart';
import 'firebase_auth_service_firebase_test.mocks.dart';

class MockFirebaseAuth extends Mock implements FirebaseAuth {
  final bool isSignedIn;

  MockFirebaseAuth({this.isSignedIn = false});

  @override
  Future<UserCredential> signInWithCredential(AuthCredential? credential) =>
      Future.value(_userCredential);

  @override
  Future<UserCredential> signOut() => Future.value(_userCredential);

  @override
  User? get currentUser => isSignedIn ? _user : null;

  @override
  Stream<User?> userChanges() {
    return Stream.value(currentUser);
  }
}

class MockUser extends Mock implements User {
  @override
  bool get isAnonymous => false;

  @override
  String get uid => userMock.uid;

  @override
  String? get email => userMock.email;

  @override
  String? get displayName => userMock.name;
}

class MockGoogleSignInAuthentication extends Mock
    implements GoogleSignInAuthentication {
  @override
  String? get accessToken => 'abc123';

  @override
  String? get idToken => 'abc123';
}

final _userCredential = MockUserCredential();
final _user = MockUser();

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

      when(_userCredential.user).thenReturn(_user);

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
        'Should throws FirebaseSignInError with invalid credential message when throw FirebaseAuthException',
        (() async {
      when(googleSignIn.signIn())
          .thenThrow(FirebaseAuthException(code: 'invalid-credential'));

      expect(
          authService.signInWithGoogle(),
          ErrorWithMessage<FirebaseSignInError>(
              AppLocalizations.current.credentialIsInvalid));
    }));
    test(
        'Should throws FirebaseSignInError with unknow message when throw Exception',
        (() async {
      when(googleSignIn.signIn()).thenThrow(Exception());

      expect(
          authService.signInWithGoogle(),
          ErrorWithMessage<FirebaseSignInError>(
              AppLocalizations.current.unknowError));
    }));
  });

  group('Sign out', () {
    test('Should sign out with google', (() async {
      firebaseAuth = MockFirebaseAuth(isSignedIn: true);
      authService = FirebaseAuthService(
        googleSignIn: googleSignIn,
        firebaseAuth: firebaseAuth,
        user: userMock,
      );

      expect(authService.user, isNotNull);

      when(googleSignIn.signOut()).thenAnswer((_) async => null);
      await authService.signOut();

      expect(authService.user, null);
    }));

    test(
        'Should throws FirebaseSignInError with emailIsInvalid error message when throw FirebaseAuthException',
        (() async {
      when(googleSignIn.signOut())
          .thenThrow(FirebaseAuthException(code: 'invalid-email'));

      expect(
          authService.signOut(),
          ErrorWithMessage<FirebaseSignInError>(
              AppLocalizations.current.emailIsInvalid));
    }));

    test(
        'Should throws FirebaseSignInError with unknowError error message when throw Exception',
        (() async {
      when(googleSignIn.signOut()).thenThrow(Exception());

      expect(
          authService.signOut(),
          ErrorWithMessage<FirebaseSignInError>(
              AppLocalizations.current.unknowError));
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
        user: userMock,
      );
      final result = authService.userChanges();

      result.listen((event) {
        expect(event, isNotNull);
        expect(event!.uid, _user.uid);
      });
    });
  });
}

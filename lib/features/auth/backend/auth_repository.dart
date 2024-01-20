import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) async* {
  yield* ref.watch(authRepositoryProvider).authStateChanges.map((user) {
    return user;
  }).handleError((e) => throw Exception(e as String));
}

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    firebaseAuth: ref.watch(authProvider),
  );
}

class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  const AuthRepository({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  User? get currentUser => FirebaseAuth.instance.currentUser;

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.i.logOut();
  }

  Future<void> googleLogin() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return;
    }

    final googleAuth = await googleUser.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      await _firebaseAuth.signInWithCredential(
        oauthCredentials,
      );
    } catch (e) {}
  }

  Future<void> facebookLogin() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (loginResult.status != LoginStatus.success || token == null) {
      return;
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      await _firebaseAuth.signInWithCredential(
        oauthCredentials,
      );
    } on FirebaseAuthException catch (e) {
      await _handleFirebaseAuthException(e);
    } catch (e) {}
  }

  Future<void> _handleFirebaseAuthException(
    FirebaseAuthException e,
  ) async {
    final email = e.email;
    final credential = e.credential;
    if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
        email != null &&
        credential != null) {
      final providers = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (providers.contains(Constants.googleCom)) {
        await googleLogin();
        _firebaseAuth.currentUser?.linkWithCredential(credential);
      }
      return;
    }

    // Questo codice non è necessario, ma serve per dimonstrare
    // come si può gestire un errore di autenticazione con maggiore dettaglio
    // const errorToResultMap = {
    //   'invalid-credential': AuthResult.failure,
    // };
    // final result = errorToResultMap[e.code] ?? AuthResult.aborted;
  }
}

import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
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

  Future<AuthState> logOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.i.logOut();
    return AuthState(
      result: null,
      user: null,
    );
  }

  Future<AuthState> googleLogin() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) {
      return _createAuthState(AuthResult.aborted);
    }

    final googleAuth = await googleUser.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    try {
      final _userCredential = await _firebaseAuth.signInWithCredential(
        oauthCredentials,
      );
      return _createAuthState(AuthResult.success, _userCredential.user);
    } catch (e) {
      return _createAuthState(AuthResult.aborted);
    }
  }

  Future<AuthState> facebookLogin() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (loginResult.status != LoginStatus.success || token == null) {
      return _createAuthState(AuthResult.aborted);
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    try {
      final _userCredentials = await _firebaseAuth.signInWithCredential(
        oauthCredentials,
      );
      return _createAuthState(AuthResult.success, _userCredentials.user);
    } on FirebaseAuthException catch (e) {
      return await _handleFirebaseAuthException(e);
    } catch (e) {
      return _createAuthState(AuthResult.aborted);
    }
  }

  Future<AuthState> _handleFirebaseAuthException(
    FirebaseAuthException e,
  ) async {
    final email = e.email;
    final credential = e.credential;
    if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
        email != null &&
        credential != null) {
      final providers = await _firebaseAuth.fetchSignInMethodsForEmail(email);
      if (providers.contains(Constants.googleCom)) {
        final res = await googleLogin();
        _firebaseAuth.currentUser?.linkWithCredential(credential);
        return res;
      }
      return _createAuthState(
        AuthResult.success,
      );
    }
    const errorToResultMap = {
      'invalid-credential': AuthResult.failure,
    };

    final result = errorToResultMap[e.code] ?? AuthResult.aborted;
    return _createAuthState(result);
  }

  AuthState _createAuthState(AuthResult result, [User? user]) {
    return AuthState(
      result: result,
      user: user,
    );
  }
}

import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'google_auth_repository.g.dart';

@riverpod
GoogleAuthRepository googleAuthRepository(GoogleAuthRepositoryRef ref) {
  return GoogleAuthRepository(
    firebaseAuth: ref.watch(authProvider),
  );
}

class GoogleAuthRepository {
  final FirebaseAuth _firebaseAuth;
  GoogleAuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<AuthState> login() async {
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

  Future<void> signOut() async {
    await GoogleSignIn().signOut();
  }

  AuthState _createAuthState(AuthResult result, [User? user]) {
    return AuthState(
      result: result,
      isLoading: false,
      user: user,
    );
  }
}

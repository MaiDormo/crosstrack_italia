import 'package:crosstrack_italia/features/auth/backend/google_auth_repository.dart';
import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'facebook_auth_repository.g.dart';

@riverpod
FacebookAuthRepository facebookAuthRepository(FacebookAuthRepositoryRef ref) {
  return FacebookAuthRepository(
    firebaseAuth: ref.watch(authProvider),
    googleAuthRepository: ref.watch(googleAuthRepositoryProvider),
  );
}

class FacebookAuthRepository {
  final FirebaseAuth _firebaseAuth;
  final GoogleAuthRepository _googleAuthRepository;
  FacebookAuthRepository(
      {required FirebaseAuth firebaseAuth,
      required GoogleAuthRepository googleAuthRepository})
      : _firebaseAuth = firebaseAuth,
        _googleAuthRepository = googleAuthRepository;

  Future<AuthState> login() async {
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

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }

  AuthState _createAuthState(AuthResult result, [User? user]) {
    return AuthState(
      result: result,
      isLoading: false,
      user: user,
    );
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
        final res = await _googleAuthRepository.login();
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
}

import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    auth: ref.watch(authProvider),
  );
}

class AuthRepository {
  final FirebaseAuth _auth;
  AuthRepository({required FirebaseAuth auth}) : _auth = auth;

  // getters
  bool get isAlreadyLoggedIn => userId != null;
  UserId? get userId => _auth.currentUser?.uid;
  String get displayName => _auth.currentUser?.displayName ?? '';
  String? get email => _auth.currentUser?.email;
  String? get profileImageUrl => _auth.currentUser?.photoURL ?? '';

  Future<void> logOut() async {
    await _auth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.instance.logOut();
  }

  Future<AuthResult> loginWithFacebook() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (loginResult.status != LoginStatus.success || token == null) {
      return AuthResult.aborted;
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    final userData = FacebookAuth.i.getUserData(
      fields:
          "${Constants.facebookName},${Constants.facebookEmailScope},${Constants.facebookImageRequest}",
    );

    await userData.then((value) {
      //update the user display name and image
      _auth.currentUser?.updateDisplayName(
        value[Constants.facebookName],
      );
      // print(value['picture']['data']['url']);
      // facebookImageUrl = value['picture']['data']['url'];
    });

    try {
      await _auth.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
          email != null &&
          credential != null) {
        final providers = await _auth.fetchSignInMethodsForEmail(email);
        if (providers.contains(Constants.googleCom)) {
          await loginWithGoogle();
        }
        return AuthResult.success;
      }
      return AuthResult.failure;
    }
  }

  Future<AuthResult> loginWithGoogle() async {
    final GoogleSignIn googleSignIn = GoogleSignIn(
      scopes: [
        Constants.emailScope,
      ],
    );
    final signInAccount = await googleSignIn.signIn();
    if (signInAccount == null) {
      return AuthResult.aborted;
    }

    final googleAuth = await signInAccount.authentication;
    final oauthCredentials = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    try {
      await _auth.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}

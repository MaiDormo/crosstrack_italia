import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
//Responsible for handling all the backend authentication logic
//basically a bunch of functions that call firebase auth

class Authenticator {
  const Authenticator();

  // getters
  bool get isAlreadyLoggedIn => userId != null;
  UserId? get userId => FirebaseAuth.instance.currentUser?.uid;
  String get displayName =>
      FirebaseAuth.instance.currentUser?.displayName ?? '';
  String? get email => FirebaseAuth.instance.currentUser?.email;
  String? get profileImageUrl =>
      FirebaseAuth.instance.currentUser?.photoURL ?? '';

  Future<void> logOut() async {
    await FirebaseAuth.instance.signOut();
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
      FirebaseAuth.instance.currentUser?.updateDisplayName(
        value[Constants.facebookName],
      );
      // print(value['picture']['data']['url']);
      // facebookImageUrl = value['picture']['data']['url'];
    });

    try {
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } on FirebaseAuthException catch (e) {
      final email = e.email;
      final credential = e.credential;
      if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
          email != null &&
          credential != null) {
        final providers =
            await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
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
      await FirebaseAuth.instance.signInWithCredential(
        oauthCredentials,
      );
      return AuthResult.success;
    } catch (e) {
      return AuthResult.failure;
    }
  }
}

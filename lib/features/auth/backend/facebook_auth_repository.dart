import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'facebook_auth_repository.g.dart';

@riverpod
FacebookAuthRepository facebookAuthRepository(FacebookAuthRepositoryRef ref) {
  return FacebookAuthRepository(
    firebaseAuth: ref.watch(authProvider),
  );
}

class FacebookAuthRepository {
  final FirebaseAuth _firebaseAuth;
  FacebookAuthRepository({required FirebaseAuth firebaseAuth})
      : _firebaseAuth = firebaseAuth;

  Future<AuthState> login() async {
    final loginResult = await FacebookAuth.instance.login();
    final token = loginResult.accessToken?.token;
    if (loginResult.status != LoginStatus.success || token == null) {
      return _createAuthState(AuthResult.aborted);
    }

    final oauthCredentials = FacebookAuthProvider.credential(token);

    final userData = await FacebookAuth.i.getUserData(
      fields:
          "${Constants.facebookName},${Constants.facebookEmailScope},${Constants.facebookImageRequest}",
    );

    //update the user display name and image
    _firebaseAuth.currentUser?.updateDisplayName(
      userData[Constants.facebookName],
    );

    try {
      final user = await _firebaseAuth.signInWithCredential(
        oauthCredentials,
      );
      return _createAuthState(AuthResult.success, user);
    } on FirebaseAuthException catch (e) {
      return _handleFirebaseAuthException(e);
    } catch (e) {
      return _createAuthState(AuthResult.aborted);
    }
  }

  Future<void> signOut() async {
    await FacebookAuth.instance.logOut();
  }

  AuthState _createAuthState(AuthResult result,
      [UserCredential? userCredential]) {
    return AuthState(
      result: result,
      isLoading: false,
      userInfoModel: userCredential != null
          ? UserInfoModel.fromUserCredential(userCredential)
          : null,
    );
  }

  AuthState _handleFirebaseAuthException(FirebaseAuthException e) {
    const errorToResultMap = {
      'account-exists-with-different-credential': AuthResult.failure,
      'invalid-credential': AuthResult.failure,
    };

    final result = errorToResultMap[e.code] ?? AuthResult.aborted;
    return _createAuthState(result);
  }
}

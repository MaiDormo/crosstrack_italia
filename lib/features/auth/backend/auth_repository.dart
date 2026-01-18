import 'package:crosstrack_italia/features/auth/constants/constants.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

/// Provides a stream of authentication state changes.
///
/// Emits the current [User] when logged in, or null when logged out.
/// Use this to reactively update UI based on authentication status.
@riverpod
Stream<User?> authStateChanges(AuthStateChangesRef ref) async* {
  yield* ref.watch(authRepositoryProvider).authStateChanges.map((user) {
    return user;
  }).handleError((e) => throw Exception(e as String));
}

/// Provides an [AuthRepository] instance with Firebase Auth dependency injected.
@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    firebaseAuth: ref.watch(authProvider),
  );
}

/// Repository for handling user authentication.
///
/// Supports multiple authentication providers:
/// - Google Sign-In
/// - Facebook Login
///
/// Handles account linking when a user tries to sign in with a different
/// provider but using the same email address.
///
/// Example usage:
/// ```dart
/// final authRepo = ref.watch(authRepositoryProvider);
/// await authRepo.googleLogin();
/// ```
class AuthRepository {
  final FirebaseAuth _firebaseAuth;

  /// Creates a new [AuthRepository] with the given Firebase Auth instance.
  const AuthRepository({
    required FirebaseAuth firebaseAuth,
  }) : _firebaseAuth = firebaseAuth;

  /// Returns the currently authenticated user, or null if not logged in.
  User? get currentUser => _firebaseAuth.currentUser;

  /// Stream of authentication state changes.
  ///
  /// Emits [User] when logged in, null when logged out.
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  /// Signs out the user from all authentication providers.
  ///
  /// Clears Firebase Auth session, Google Sign-In, and Facebook Login.
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
    await FacebookAuth.i.logOut();
  }

  /// Initiates Google Sign-In flow.
  ///
  /// Opens the Google Sign-In dialog and authenticates with Firebase
  /// upon successful Google authentication.
  ///
  /// Does nothing if the user cancels the sign-in dialog.
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
    } catch (e) {
      debugPrint('Google login error: $e');
    }
  }

  /// Initiates Facebook Login flow.
  ///
  /// Opens the Facebook Login dialog and authenticates with Firebase
  /// upon successful Facebook authentication.
  ///
  /// If the email is already associated with a Google account, this method
  /// will attempt to link the accounts automatically.
  ///
  /// Does nothing if the user cancels the login dialog or login fails.
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
    } catch (e) {
      debugPrint('Facebook login error: $e');
    }
  }

  /// Handles Firebase Auth exceptions, particularly account linking.
  ///
  /// When a user tries to sign in with Facebook but their email is already
  /// associated with a Google account, this method will:
  /// 1. Sign in with Google
  /// 2. Link the Facebook credential to the Google account
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
  }
}

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
Stream<User?> authStateChanges(Ref ref) async* {
  yield* ref.watch(authRepositoryProvider).authStateChanges.map((user) {
    return user;
  }).handleError((e) => throw Exception(e as String));
}

/// Provides an [AuthRepository] instance with Firebase Auth dependency injected.
@riverpod
AuthRepository authRepository(Ref ref) {
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
  GoogleSignIn? _googleSignIn;
  bool _googleSignInInitialized = false;
  bool _googleSignInAvailable = true;

  /// Creates a new [AuthRepository] with the given Firebase Auth instance.
  AuthRepository({
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
    try {
      if (!kIsWeb && _googleSignIn != null) {
        await _googleSignIn!.disconnect();
      }
    } catch (e) {
      debugPrint('Google sign out error: $e');
    }
    await FacebookAuth.i.logOut();
  }

  /// Initiates Google Sign-In flow.
  ///
  /// On web, uses Firebase Auth's signInWithPopup for better compatibility.
  /// On mobile, uses the google_sign_in package.
  Future<void> googleLogin() async {
    if (kIsWeb) {
      await _googleLoginWeb();
    } else {
      await _googleLoginMobile();
    }
  }

  /// Google Sign-In for web using Firebase Auth popup
  Future<void> _googleLoginWeb() async {
    try {
      debugPrint('Starting Google Sign-In for web...');
      
      final googleProvider = GoogleAuthProvider();
      googleProvider.addScope('email');
      googleProvider.addScope('profile');
      
      // Use popup for web - this is the most reliable method
      final userCredential = await _firebaseAuth.signInWithPopup(googleProvider);
      
      debugPrint('Web Google Sign-In successful: ${userCredential.user?.email}');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'popup-closed-by-user' || e.code == 'cancelled-popup-request') {
        debugPrint('Google Sign-In popup closed by user');
        return;
      }
      debugPrint('Firebase Auth error: ${e.code} - ${e.message}');
      rethrow;
    } catch (e, stack) {
      debugPrint('Web Google login error: $e');
      debugPrint('Stack: $stack');
      rethrow;
    }
  }

  /// Google Sign-In for mobile using google_sign_in package
  Future<void> _googleLoginMobile() async {
    try {
      final initialized = await _ensureGoogleSignInInitialized();
      if (!initialized || _googleSignIn == null) {
        debugPrint('Google Sign-In not available');
        return;
      }
      
      GoogleSignInAccount? googleUser;
      
      // Try silent sign-in first
      try {
        final lightweightFuture = _googleSignIn!.attemptLightweightAuthentication();
        if (lightweightFuture != null) {
          googleUser = await lightweightFuture;
          debugPrint('Lightweight auth result: $googleUser');
        }
      } catch (e) {
        debugPrint('Lightweight auth failed: $e');
      }
      
      // If no user from lightweight auth, try full authentication
      if (googleUser == null) {
        if (_googleSignIn!.supportsAuthenticate()) {
          debugPrint('Attempting full authentication...');
          googleUser = await _googleSignIn!.authenticate();
          debugPrint('Full auth result: $googleUser');
        } else {
          debugPrint('Full authentication not supported on this platform');
          return;
        }
      }
      
      if (googleUser == null) {
        debugPrint('Google Sign-In cancelled or failed');
        return;
      }

      // Get authorization for accessing user info
      debugPrint('Getting authorization...');
      final authorization = await googleUser.authorizationClient.authorizeScopes(['email']);
      debugPrint('Got access token: ${authorization.accessToken != null}');
      
      if (authorization.accessToken == null) {
        debugPrint('No access token received');
        return;
      }

      final oauthCredentials = GoogleAuthProvider.credential(
        accessToken: authorization.accessToken,
      );

      debugPrint('Signing in with Firebase...');
      await _firebaseAuth.signInWithCredential(oauthCredentials);
      debugPrint('Firebase sign-in successful');
    } on GoogleSignInException catch (e) {
      if (e.code == GoogleSignInExceptionCode.canceled) {
        debugPrint('Google Sign-In cancelled by user');
        return;
      }
      debugPrint('Google Sign-In exception: ${e.code}');
    } catch (e, stack) {
      debugPrint('Mobile Google login error: $e');
      debugPrint('Stack trace: $stack');
    }
  }

  /// Ensures Google Sign-In is initialized before use (mobile only).
  Future<bool> _ensureGoogleSignInInitialized() async {
    if (!_googleSignInAvailable) return false;
    
    if (!_googleSignInInitialized) {
      try {
        _googleSignIn = GoogleSignIn.instance;
        await _googleSignIn!.initialize();
        _googleSignInInitialized = true;
        debugPrint('Google Sign-In initialized successfully');
      } catch (e) {
        debugPrint('Google Sign-In initialization failed: $e');
        _googleSignInAvailable = false;
        return false;
      }
    }
    return true;
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
    final accessToken = loginResult.accessToken;
    if (loginResult.status != LoginStatus.success || accessToken == null) {
      return;
    }

    final oauthCredentials = FacebookAuthProvider.credential(accessToken.tokenString);

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
  ///
  /// Note: fetchSignInMethodsForEmail is deprecated, so we now catch the
  /// account-exists error and prompt for Google login directly.
  Future<void> _handleFirebaseAuthException(
    FirebaseAuthException e,
  ) async {
    final email = e.email;
    final credential = e.credential;
    if (e.code == Constants.accountExistsWithDifferentCredentialsError &&
        email != null &&
        credential != null) {
      // fetchSignInMethodsForEmail is deprecated - directly try Google login
      // since that's the most common provider for this app
      await googleLogin();
      _firebaseAuth.currentUser?.linkWithCredential(credential);
      return;
    }
  }
}

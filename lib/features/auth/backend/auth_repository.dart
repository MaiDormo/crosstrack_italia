import 'package:crosstrack_italia/features/auth/backend/facebook_auth_repository.dart';
import 'package:crosstrack_italia/features/auth/backend/google_auth_repository.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

@riverpod
AuthRepository authRepository(AuthRepositoryRef ref) {
  return AuthRepository(
    auth: ref.watch(authProvider),
    googleAuthRepository: ref.watch(googleAuthRepositoryProvider),
    facebookAuthRepository: ref.watch(facebookAuthRepositoryProvider),
  );
}

class AuthRepository {
  final FirebaseAuth _auth;
  final GoogleAuthRepository _googleAuthRepository;
  final FacebookAuthRepository _facebookAuthRepository;

  AuthRepository({
    required FirebaseAuth auth,
    required GoogleAuthRepository googleAuthRepository,
    required FacebookAuthRepository facebookAuthRepository,
  })  : _auth = auth,
        _googleAuthRepository = googleAuthRepository,
        _facebookAuthRepository = facebookAuthRepository;

  User? get currentUser => _auth.currentUser;

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  bool isLogged() {
    return _auth.currentUser != null;
  }

  Future<AuthState> logOut() async {
    await _auth.signOut();
    await _googleAuthRepository.signOut();
    await _facebookAuthRepository.signOut();
    return AuthState(
      result: null,
      isLoading: false,
      user: null,
    );
  }

  Future<AuthState> loginWithFacebook() async {
    return await _facebookAuthRepository.login();
  }

  Future<AuthState> loginWithGoogle() async {
    return await _googleAuthRepository.login();
  }
}

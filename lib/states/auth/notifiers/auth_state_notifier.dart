import 'package:crosstrack_italia/states/auth/backend/authenticator.dart';
import 'package:crosstrack_italia/states/auth/models/auth_result.dart';
import 'package:crosstrack_italia/states/auth/models/auth_state.dart';
import 'package:crosstrack_italia/states/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/states/user_info/backend/user_info_storage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.userId,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> loginWithEmailandPassword({
    required String email,
    required String password,
  }) async {
    state = state.copiedWithIsLoading(true);
    final result =
        await _authenticator.loginWithEmailandPassword(email, password);
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.userId,
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
      );
}

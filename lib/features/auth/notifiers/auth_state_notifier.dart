import 'package:crosstrack_italia/features/auth/backend/authenticator.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/backend/user_info_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_notifier.g.dart';

//------------------PROVIDERS------------------//

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.result != null;
}

@riverpod
UserId? userId(UserIdRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.userId;
}

//for the loading screeen
@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.isLoading;
}

//------------------NOTIFIERS------------------//
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  @override
  AuthState build() {
    return _authenticator.isAlreadyLoggedIn
        ? AuthState(
            result: AuthResult.success,
            isLoading: false,
            userId: _authenticator.userId,
          )
        : const AuthState(
            result: null,
            isLoading: false,
            userId: null,
          );
  }

  Future<void> logOut() async {
    state = state.copyWith(isLoading: true);
    await _authenticator.logOut();
    state = const AuthState(
      result: null,
      isLoading: false,
      userId: null,
    );
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.userId;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
      state = AuthState(
        result: result,
        isLoading: false,
        userId: _authenticator.userId,
      );
    } else {
      state = const AuthState(
        result: null,
        isLoading: false,
        userId: null,
      );
    }
  }

  Future<void> loginWithFacebook() async {
    state = state.copyWith(isLoading: true);
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

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.displayName,
        email: _authenticator.email,
        profileImageUrl: _authenticator.profileImageUrl,
      );
}

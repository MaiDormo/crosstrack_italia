import 'dart:async';

import 'package:crosstrack_italia/features/auth/backend/auth_repository.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_notifier.g.dart';

//------------------NOTIFIERS------------------//

@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  late var _authRepository;

  @override
  Stream<AuthState> build() async* {
    _authRepository = ref.watch(authRepositoryProvider);
    await for (final user in _authRepository.authStateChanges) {
      yield user != null
          ? AuthState(
              result: AuthResult.success,
              isLoading: false,
              user: user,
            )
          : const AuthState(
              result: null,
              isLoading: false,
              user: null,
            );
    }
  }

  Future<void> logOut() async {
    state = AsyncLoading();
    final res = await _authRepository.logOut();
    state = AsyncData(res);
  }

  Future<void> loginWithProvider(
      Future<AuthState> Function() loginMethod) async {
    state = AsyncLoading();
    try {
      final res = await loginMethod();
      state = AsyncData(res);
    } catch (e) {
      state = AsyncData(
        const AuthState(
          result: null,
          isLoading: false,
          user: null,
        ),
      );
      print('Error logging in with provider: $e');
    }
  }

  Future<void> loginWithGoogle() async {
    await loginWithProvider(_authRepository.loginWithGoogle);
  }

  Future<void> loginWithFacebook() async {
    await loginWithProvider(_authRepository.loginWithFacebook);
  }
}

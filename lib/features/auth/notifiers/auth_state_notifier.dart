import 'dart:async';

import 'package:crosstrack_italia/features/auth/backend/auth_repository.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/backend/user_info_storage.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_notifier.g.dart';

//------------------PROVIDERS------------------//

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.userInfoModel?.id != null;
}

@riverpod
UserId? userId(UserIdRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.userInfoModel?.id;
}

//for the loading screeen
@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.isLoading;
}

@riverpod
Future<Widget> userImage(UserImageRef ref) async {
  final _authstateNotifier = ref.watch(authStateNotifierProvider.notifier);
  final _isLogged = ref.watch(isLoggedInProvider);

  return _authstateNotifier.userImage(
    _isLogged,
  );
}

@riverpod
Stream<UserInfoModel> fetchUserInfo(
    FetchUserInfoRef ref, UserId userId) async* {
  final controller = StreamController<UserInfoModel>();

  final sub = ref
      .watch(firestoreProvider)
      .collection(
        FirebaseCollectionName.users,
      )
      .where(
        FirebaseFieldName.id,
        isEqualTo: userId,
      )
      .limit(1)
      .snapshots()
      .listen(
    (snapshot) {
      if (snapshot.docs.isNotEmpty) {
        final doc = snapshot.docs.first;
        final json = doc.data();
        final userInfo = UserInfoModel.fromJson(json);
        controller.add(userInfo);
      }
    },
  );

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  yield* controller.stream;
}

@riverpod
Future<List<TrackId>> fetchFavoriteTracks(FetchFavoriteTracksRef ref) async {
  final authState = ref.watch(authStateNotifierProvider.notifier);
  return await authState.fetchFavoriteTracks();
}

//------------------NOTIFIERS------------------//
@riverpod
class AuthStateNotifier extends _$AuthStateNotifier {
  late var _authRepository;
  late var _userInfoStorage;

  @override
  AuthState build() {
    _userInfoStorage = ref.watch(userInfoStorageProvider.notifier);
    _authRepository = ref.watch(authRepositoryProvider);
    return _authRepository.isLogged()
        ? AuthState(
            result: AuthResult.success,
            isLoading: false,
            userInfoModel: UserInfoModel.fromUser(_authRepository.user!),
          )
        : const AuthState(
            result: null,
            isLoading: false,
            userInfoModel: null,
          );
  }

  Future<void> logOut() async {
    state = state.copyWith(isLoading: true);
    await _authRepository.logOut();
    state = const AuthState(
      result: null,
      isLoading: false,
      userInfoModel: null,
    );
  }

  Future<void> loginWithGoogle() async {
    try {
      state = state.copyWith(isLoading: true);
      final AuthState res = await _authRepository.loginWithGoogle();

      if (res.result != AuthResult.success && res.userInfoModel?.id == null) {
        state = res;
        return;
      }

      final AsyncValue<UserInfoModel> _asyncUserInfo =
          await ref.watch(fetchUserInfoProvider(res.userInfoModel!.id));
      final UserInfoModel? userInfo = await _asyncUserInfo
          .whenData((value) => value)
          .asData
          ?.unwrapPrevious()
          .valueOrNull;

      if (userInfo == null) {
        await saveUserInfo(
          userInfoModel: res.userInfoModel,
        );
        state = res;
      } else {
        state = state.copyWith(userInfoModel: userInfo);
      }
    } catch (e) {
      print('Error logging in with Google: $e');
      state = AuthState(
        result: null,
        isLoading: false,
        userInfoModel: null,
      );
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      state = state.copyWith(isLoading: true);
      final AuthState res = await _authRepository.loginWithFacebook();

      if (res.result != AuthResult.success && res.userInfoModel?.id == null) {
        state = res;
        return Future.value();
      }

      final AsyncValue<UserInfoModel> _asyncUserInfo =
          await ref.watch(fetchUserInfoProvider(res.userInfoModel!.id));
      final userInfo = await _asyncUserInfo
          .whenData((value) => value)
          .asData
          ?.unwrapPrevious()
          .valueOrNull;

      if (userInfo == null) {
        await saveUserInfo(
          userInfoModel: res.userInfoModel,
        );
        state = res;
      } else {
        state = state.copyWith(userInfoModel: userInfo);
      }
    } catch (e) {
      state = AuthState(
        result: null,
        isLoading: false,
        userInfoModel: null,
      );
    }
  }

  Future<void> saveUserInfo({
    UserInfoModel? userInfoModel,
    List<TrackId>? favoriteTracks,
  }) async {
    return userInfoModel != null
        ? favoriteTracks != null
            ? await _userInfoStorage.saveUserInfo(
                userInfoModel: userInfoModel,
              )
            : await _userInfoStorage.saveUserInfo(
                userInfoModel: userInfoModel.copyWith(
                  favoriteTracks: favoriteTracks,
                ),
              )
        : Future.value();
  }

  Widget userImage(bool isLogged) {
    if (isLogged) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Image.network(
          state.userInfoModel!.profileImageUrl!,
          fit: BoxFit.cover,
          width: 35,
          height: 35,
        ),
      );
    } else {
      return Icon(Icons.account_circle);
    }
  }

  Future<List<TrackId>> fetchFavoriteTracks() async {
    final id = state.userInfoModel?.id;
    if (id == null) {
      return [];
    }
    final AsyncValue<UserInfoModel> userInfoModel =
        await ref.watch(fetchUserInfoProvider(id));
    return userInfoModel.when(
      data: (value) => value.favoriteTracks ?? [],
      loading: () => [],
      error: (error, stackTrace) => [],
    );
  }

  Future<List<TrackId>> fetchOwnedTracks() async {
    final id = state.userInfoModel?.id;
    if (id == null) {
      return [];
    }
    final AsyncValue<UserInfoModel> userInfoModel =
        await ref.watch(fetchUserInfoProvider(id));
    return userInfoModel.when(
      data: (value) => value.ownedTracks ?? [],
      loading: () => [],
      error: (error, stackTrace) => [],
    );
  }
}

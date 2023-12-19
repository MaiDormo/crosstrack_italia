import 'dart:async';

import 'package:crosstrack_italia/features/auth/backend/auth_repository.dart';
import 'package:crosstrack_italia/features/auth/models/auth_result.dart';
import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/backend/user_info_storage.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_state_notifier.g.dart';

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

  Future<void> loginWithProvider(
      Future<AuthState> Function() loginMethod) async {
    try {
      state = state.copyWith(isLoading: true);
      final AuthState res = await loginMethod();

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
      print('Error logging in with provider: $e');
      state = AuthState(
        result: null,
        isLoading: false,
        userInfoModel: null,
      );
    }
  }

  Future<void> loginWithGoogle() async {
    await loginWithProvider(_authRepository.loginWithGoogle);
  }

  Future<void> loginWithFacebook() async {
    await loginWithProvider(_authRepository.loginWithFacebook);
  }

  Future<void> saveUserInfo({
    UserInfoModel? userInfoModel,
    List<TrackId>? favoriteTracks,
    List<TrackId>? ownedTracks,
  }) async {
    if (userInfoModel == null) {
      return Future.value();
    }

    UserInfoModel updatedUserInfoModel = userInfoModel;

    if (favoriteTracks != null) {
      updatedUserInfoModel = updatedUserInfoModel.copyWith(
        favoriteTracks: favoriteTracks,
      );
    }

    if (ownedTracks != null) {
      updatedUserInfoModel = updatedUserInfoModel.copyWith(
        ownedTracks: ownedTracks,
      );
    }

    return await _userInfoStorage.saveUserInfo(
      userInfoModel: updatedUserInfoModel,
    );
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

  Future<void> makeOwner(List<TrackId> ownedTracks) async {
    final user = state.userInfoModel!.copyWith(
      isOwner: true,
      ownedTracks: ownedTracks,
    );
    state = state.copyWith(userInfoModel: user);
    await saveUserInfo(userInfoModel: user);
  }
}

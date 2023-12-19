import 'dart:async';

import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

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

@riverpod
bool isOwner(IsOwnerRef ref) {
  final authState = ref.watch(authStateNotifierProvider);
  return authState.userInfoModel?.isOwner ?? false;
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

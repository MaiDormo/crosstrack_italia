import 'dart:async';

import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_providers.g.dart';

@riverpod
bool isLoggedIn(IsLoggedInRef ref) {
  final _userState = ref.watch(userStateNotifierProvider);
  return switch (_userState) {
    AsyncData(:final value) => value.id != '',
    _ => false,
  };
}

@riverpod
UserId userId(UserIdRef ref) {
  final _userState = ref.watch(userStateNotifierProvider);
  return switch (_userState) {
    AsyncData(:final value) => value.id,
    _ => '',
  }; //TODO: check if this is correct
}

@riverpod
bool isOwner(IsOwnerRef ref) {
  final _userState = ref.watch(userStateNotifierProvider);
  return switch (_userState) {
    AsyncData(:final value) => value.isOwner,
    _ => false,
  };
}

//for the loading screeen
@riverpod
bool isLoading(IsLoadingRef ref) {
  final _authState = ref.watch(authStateNotifierProvider);
  return switch (_authState) {
    AsyncData(:final value) => value.isLoading,
    _ => false,
  };
}

@riverpod
Widget userImage(UserImageRef ref) {
  final _userState = ref.watch(userStateNotifierProvider);
  final _isLogged = ref.watch(isLoggedInProvider);

  if (_isLogged) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: switch (_userState) {
        AsyncData(:final value) => Image.network(
            value.profileImageUrl!,
            height: 35.h,
            width: 35.w,
            fit: BoxFit.cover,
          ),
        AsyncError() => Icon(Icons.error),
        _ => CircularProgressIndicator(),
      },
    );
  } else {
    return Icon(Icons.account_circle);
  }
}

@riverpod
Future<List<TrackId>> fetchFavoriteTracks(FetchFavoriteTracksRef ref) async {
  final _userState = ref.watch(userStateNotifierProvider.notifier);
  return await _userState.fetchFavoriteTracks();
}

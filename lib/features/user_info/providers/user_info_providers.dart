import 'dart:async';

import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/user_roles.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_providers.g.dart';

@riverpod
bool isLoggedIn(Ref ref) {
  final _userState = ref.watch(userStateProvider);
  return switch (_userState) {
    AsyncData(:final value) => value.id.isNotEmpty,
    _ => false,
  };
}

@riverpod
UserId userId(Ref ref) {
  final _userState = ref.watch(userStateProvider);
  return switch (_userState) {
    AsyncData(:final value) => value.id,
    _ => '',
  };
}

@riverpod
bool isOwner(Ref ref) {
  final _userState = ref.watch(userStateProvider);
  return switch (_userState) {
    AsyncData(:final value) => value.role == UserRole.owner,
    _ => false,
  };
}

@riverpod
Widget userImage(Ref ref) {
  final _userState = ref.watch(userStateProvider);
  final _isLogged = ref.watch(isLoggedInProvider);
  if (_isLogged) {
    final providerId =
        ref.watch(authProvider).currentUser?.providerData[0].providerId;
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: switch (_userState) {
        AsyncData(:final value) => providerId != 'facebook.com' &&
                value.profileImageUrl != null &&
                value.profileImageUrl!.isNotEmpty
            ? Image.network(
                value.profileImageUrl!,
                height: 35.h,
                width: 35.w,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  // Fallback to default icon on error (e.g., 429 rate limit)
                  return Icon(
                    Icons.account_circle,
                    size: 35.h,
                    color: Colors.white,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return SizedBox(
                    height: 35.h,
                    width: 35.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  );
                },
              )
            : SvgPicture.asset(
                'assets/svgs/f_logo.svg',
                height: 35.h,
                width: 35.w,
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
        AsyncError() => Icon(Icons.error),
        _ => SizedBox(
            height: 35.h,
            width: 35.w,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
      },
    );
  } else {
    return Icon(Icons.account_circle);
  }
}

@riverpod
Future<List<TrackId>> fetchFavoriteTracks(Ref ref) async {
  final _userState = ref.watch(userStateProvider.notifier);
  return await _userState.fetchFavoriteTracks();
}

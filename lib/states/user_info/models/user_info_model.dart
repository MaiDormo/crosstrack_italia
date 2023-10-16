import 'dart:collection' show MapView;

import 'package:crosstrack_italia/states/user_info/models/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_field_name.dart';

@immutable
class UserInfoModel extends MapView<String, String?> {
  final UserId userId;
  final String displayName;
  final String? email;
  final String? profileImageUrl;

  UserInfoModel({
    required this.userId,
    required this.displayName,
    required this.email,
    required this.profileImageUrl,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName,
            FirebaseFieldName.email: email,
            FirebaseFieldName.profileImageUrl: profileImageUrl,
          },
        );

  UserInfoModel.fromJson(
    Map<String, dynamic> json, {
    required UserId userId,
  }) : this(
          userId: userId,
          displayName: json[FirebaseFieldName.displayName] ?? '',
          email: json[FirebaseFieldName.email],
          profileImageUrl: json[FirebaseFieldName.profileImageUrl] ?? '',
        );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoModel &&
          runtimeType == other.runtimeType &&
          userId == other.userId &&
          displayName == other.displayName &&
          email == other.email &&
          profileImageUrl == other.profileImageUrl;

  @override
  int get hashCode => Object.hashAll(
        [
          userId,
          displayName,
          email,
          profileImageUrl,
        ],
      );
}

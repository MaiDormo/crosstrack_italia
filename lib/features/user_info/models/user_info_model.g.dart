// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserInfoModel _$UserInfoModelFromJson(
  Map<String, dynamic> json,
) => _UserInfoModel(
  id: json['id'] as String,
  displayName: json['display_name'] as String? ?? '',
  email: json['email'] as String? ?? '',
  profileImageUrl: json['profile_image_url'] as String? ?? '',
  favoriteTracks:
      (json['favorite_tracks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ?? UserRole.guest,
  ownedTracks:
      (json['owned_tracks'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$UserInfoModelToJson(_UserInfoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'email': instance.email,
      'profile_image_url': instance.profileImageUrl,
      'favorite_tracks': instance.favoriteTracks,
      'role': _$UserRoleEnumMap[instance.role]!,
      'owned_tracks': instance.ownedTracks,
    };

const _$UserRoleEnumMap = {
  UserRole.owner: 'owner',
  UserRole.user: 'user',
  UserRole.guest: 'guest',
};

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoModelImpl _$$UserInfoModelImplFromJson(Map<String, dynamic> json) =>
    _$UserInfoModelImpl(
      id: json['id'] as String,
      displayName: json['display_name'] as String?,
      email: json['email'] as String? ?? '',
      profileImageUrl: json['profile_image_url'] as String? ?? '',
      favoriteTracks: (json['tracciati_favoriti'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      isOwner: json['isOwner'] as bool? ?? false,
      ownedTracks: (json['tracciati_posseduti'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$UserInfoModelImplToJson(_$UserInfoModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'display_name': instance.displayName,
      'email': instance.email,
      'profile_image_url': instance.profileImageUrl,
      'tracciati_favoriti': instance.favoriteTracks,
      'isOwner': instance.isOwner,
      'tracciati_posseduti': instance.ownedTracks,
    };

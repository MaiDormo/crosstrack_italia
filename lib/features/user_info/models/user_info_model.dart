import 'package:crosstrack_italia/features/firebase_constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/user_roles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
abstract class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    required UserId id,
    @JsonKey(name: FirebaseFieldName.displayName)
    @Default('')
    String? displayName,
    @Default('') String? email,
    @JsonKey(name: FirebaseFieldName.profileImageUrl)
    @Default('')
    String? profileImageUrl,
    @JsonKey(name: FirebaseFieldName.favoriteTracks)
    @Default([])
    List<TrackId> favoriteTracks,
    @Default(UserRole.guest) UserRole role,
    @JsonKey(name: FirebaseFieldName.ownedTracks)
    @Default([])
    List<TrackId> ownedTracks,
  }) = _UserInfoModel;

  const UserInfoModel._();

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  factory UserInfoModel.fromUser(User user) => UserInfoModel(
        id: user.uid,
        displayName: user.displayName,
        email: user.email,
        profileImageUrl: user.photoURL,
      );

  factory UserInfoModel.empty() => UserInfoModel(id: '');
}

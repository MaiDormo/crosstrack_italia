import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
class UserInfoModel with _$UserInfoModel {
  const factory UserInfoModel({
    required UserId id,
    @JsonKey(name: FirebaseFieldName.displayName) required String? displayName,
    @Default('') String? email,
    @JsonKey(name: FirebaseFieldName.profileImageUrl)
    @Default('')
    String? profileImageUrl,
    @JsonKey(name: FirebaseFieldName.favoriteTracks)
    @Default([])
    List<String>? favoriteTracks,
  }) = _UserInfoModel;

  const UserInfoModel._();

  factory UserInfoModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoModelFromJson(json);

  factory UserInfoModel.fromUserCredential(UserCredential userCredential) =>
      UserInfoModel(
        id: userCredential.user!.uid,
        displayName: userCredential.user!.displayName,
        email: userCredential.user!.email,
        profileImageUrl: userCredential.user!.photoURL,
      );

  factory UserInfoModel.fromUser(User user) => UserInfoModel(
        id: user.uid,
        displayName: user.displayName,
        email: user.email,
        profileImageUrl: user.photoURL,
      );
}

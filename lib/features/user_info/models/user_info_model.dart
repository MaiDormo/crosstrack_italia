import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_info_model.freezed.dart';
part 'user_info_model.g.dart';

@freezed
class UserInfo with _$UserInfo {
  const factory UserInfo({
    required UserId id,
    @JsonKey(name: FirebaseFieldName.displayName) required String? displayName,
    @Default('') String? email,
    @JsonKey(name: FirebaseFieldName.profileImageUrl)
    @Default('')
    String? profileImageUrl,
  }) = _UserInfo;

  const UserInfo._();

  factory UserInfo.fromJson(Map<String, dynamic> json) =>
      _$UserInfoFromJson(json);
}

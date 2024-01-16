// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return _UserInfoModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoModel {
  String get id => throw _privateConstructorUsedError;
  @JsonKey(name: FirebaseFieldName.displayName)
  String? get displayName => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: FirebaseFieldName.profileImageUrl)
  String? get profileImageUrl => throw _privateConstructorUsedError;
  @JsonKey(name: FirebaseFieldName.favoriteTracks)
  List<String> get favoriteTracks => throw _privateConstructorUsedError;
  @JsonKey(name: FirebaseFieldName.role)
  UserRole get role => throw _privateConstructorUsedError;
  @JsonKey(name: FirebaseFieldName.ownedTracks)
  List<String> get ownedTracks => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoModelCopyWith<UserInfoModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoModelCopyWith<$Res> {
  factory $UserInfoModelCopyWith(
          UserInfoModel value, $Res Function(UserInfoModel) then) =
      _$UserInfoModelCopyWithImpl<$Res, UserInfoModel>;
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: FirebaseFieldName.displayName) String? displayName,
      String? email,
      @JsonKey(name: FirebaseFieldName.profileImageUrl) String? profileImageUrl,
      @JsonKey(name: FirebaseFieldName.favoriteTracks)
      List<String> favoriteTracks,
      @JsonKey(name: FirebaseFieldName.role) UserRole role,
      @JsonKey(name: FirebaseFieldName.ownedTracks) List<String> ownedTracks});
}

/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res, $Val extends UserInfoModel>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? profileImageUrl = freezed,
    Object? favoriteTracks = null,
    Object? role = null,
    Object? ownedTracks = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      favoriteTracks: null == favoriteTracks
          ? _value.favoriteTracks
          : favoriteTracks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      ownedTracks: null == ownedTracks
          ? _value.ownedTracks
          : ownedTracks // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserInfoModelImplCopyWith<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  factory _$$UserInfoModelImplCopyWith(
          _$UserInfoModelImpl value, $Res Function(_$UserInfoModelImpl) then) =
      __$$UserInfoModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      @JsonKey(name: FirebaseFieldName.displayName) String? displayName,
      String? email,
      @JsonKey(name: FirebaseFieldName.profileImageUrl) String? profileImageUrl,
      @JsonKey(name: FirebaseFieldName.favoriteTracks)
      List<String> favoriteTracks,
      @JsonKey(name: FirebaseFieldName.role) UserRole role,
      @JsonKey(name: FirebaseFieldName.ownedTracks) List<String> ownedTracks});
}

/// @nodoc
class __$$UserInfoModelImplCopyWithImpl<$Res>
    extends _$UserInfoModelCopyWithImpl<$Res, _$UserInfoModelImpl>
    implements _$$UserInfoModelImplCopyWith<$Res> {
  __$$UserInfoModelImplCopyWithImpl(
      _$UserInfoModelImpl _value, $Res Function(_$UserInfoModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? displayName = freezed,
    Object? email = freezed,
    Object? profileImageUrl = freezed,
    Object? favoriteTracks = null,
    Object? role = null,
    Object? ownedTracks = null,
  }) {
    return _then(_$UserInfoModelImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      profileImageUrl: freezed == profileImageUrl
          ? _value.profileImageUrl
          : profileImageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      favoriteTracks: null == favoriteTracks
          ? _value._favoriteTracks
          : favoriteTracks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as UserRole,
      ownedTracks: null == ownedTracks
          ? _value._ownedTracks
          : ownedTracks // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoModelImpl extends _UserInfoModel {
  const _$UserInfoModelImpl(
      {required this.id,
      @JsonKey(name: FirebaseFieldName.displayName) required this.displayName,
      this.email = '',
      @JsonKey(name: FirebaseFieldName.profileImageUrl)
      this.profileImageUrl = '',
      @JsonKey(name: FirebaseFieldName.favoriteTracks)
      final List<String> favoriteTracks = const [],
      @JsonKey(name: FirebaseFieldName.role) this.role = UserRole.guest,
      @JsonKey(name: FirebaseFieldName.ownedTracks)
      final List<String> ownedTracks = const []})
      : _favoriteTracks = favoriteTracks,
        _ownedTracks = ownedTracks,
        super._();

  factory _$UserInfoModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoModelImplFromJson(json);

  @override
  final String id;
  @override
  @JsonKey(name: FirebaseFieldName.displayName)
  final String? displayName;
  @override
  @JsonKey()
  final String? email;
  @override
  @JsonKey(name: FirebaseFieldName.profileImageUrl)
  final String? profileImageUrl;
  final List<String> _favoriteTracks;
  @override
  @JsonKey(name: FirebaseFieldName.favoriteTracks)
  List<String> get favoriteTracks {
    if (_favoriteTracks is EqualUnmodifiableListView) return _favoriteTracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_favoriteTracks);
  }

  @override
  @JsonKey(name: FirebaseFieldName.role)
  final UserRole role;
  final List<String> _ownedTracks;
  @override
  @JsonKey(name: FirebaseFieldName.ownedTracks)
  List<String> get ownedTracks {
    if (_ownedTracks is EqualUnmodifiableListView) return _ownedTracks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_ownedTracks);
  }

  @override
  String toString() {
    return 'UserInfoModel(id: $id, displayName: $displayName, email: $email, profileImageUrl: $profileImageUrl, favoriteTracks: $favoriteTracks, role: $role, ownedTracks: $ownedTracks)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.profileImageUrl, profileImageUrl) ||
                other.profileImageUrl == profileImageUrl) &&
            const DeepCollectionEquality()
                .equals(other._favoriteTracks, _favoriteTracks) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality()
                .equals(other._ownedTracks, _ownedTracks));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      displayName,
      email,
      profileImageUrl,
      const DeepCollectionEquality().hash(_favoriteTracks),
      role,
      const DeepCollectionEquality().hash(_ownedTracks));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      __$$UserInfoModelImplCopyWithImpl<_$UserInfoModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoModelImplToJson(
      this,
    );
  }
}

abstract class _UserInfoModel extends UserInfoModel {
  const factory _UserInfoModel(
      {required final String id,
      @JsonKey(name: FirebaseFieldName.displayName)
      required final String? displayName,
      final String? email,
      @JsonKey(name: FirebaseFieldName.profileImageUrl)
      final String? profileImageUrl,
      @JsonKey(name: FirebaseFieldName.favoriteTracks)
      final List<String> favoriteTracks,
      @JsonKey(name: FirebaseFieldName.role) final UserRole role,
      @JsonKey(name: FirebaseFieldName.ownedTracks)
      final List<String> ownedTracks}) = _$UserInfoModelImpl;
  const _UserInfoModel._() : super._();

  factory _UserInfoModel.fromJson(Map<String, dynamic> json) =
      _$UserInfoModelImpl.fromJson;

  @override
  String get id;
  @override
  @JsonKey(name: FirebaseFieldName.displayName)
  String? get displayName;
  @override
  String? get email;
  @override
  @JsonKey(name: FirebaseFieldName.profileImageUrl)
  String? get profileImageUrl;
  @override
  @JsonKey(name: FirebaseFieldName.favoriteTracks)
  List<String> get favoriteTracks;
  @override
  @JsonKey(name: FirebaseFieldName.role)
  UserRole get role;
  @override
  @JsonKey(name: FirebaseFieldName.ownedTracks)
  List<String> get ownedTracks;
  @override
  @JsonKey(ignore: true)
  _$$UserInfoModelImplCopyWith<_$UserInfoModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

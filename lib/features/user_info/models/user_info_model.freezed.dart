// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserInfoModel {

 UserId get id;@JsonKey(name: FirebaseFieldName.displayName) String? get displayName; String? get email;@JsonKey(name: FirebaseFieldName.profileImageUrl) String? get profileImageUrl;@JsonKey(name: FirebaseFieldName.favoriteTracks) List<TrackId> get favoriteTracks; UserRole get role;@JsonKey(name: FirebaseFieldName.ownedTracks) List<TrackId> get ownedTracks;
/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserInfoModelCopyWith<UserInfoModel> get copyWith => _$UserInfoModelCopyWithImpl<UserInfoModel>(this as UserInfoModel, _$identity);

  /// Serializes this UserInfoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&const DeepCollectionEquality().equals(other.favoriteTracks, favoriteTracks)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.ownedTracks, ownedTracks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,email,profileImageUrl,const DeepCollectionEquality().hash(favoriteTracks),role,const DeepCollectionEquality().hash(ownedTracks));

@override
String toString() {
  return 'UserInfoModel(id: $id, displayName: $displayName, email: $email, profileImageUrl: $profileImageUrl, favoriteTracks: $favoriteTracks, role: $role, ownedTracks: $ownedTracks)';
}


}

/// @nodoc
abstract mixin class $UserInfoModelCopyWith<$Res>  {
  factory $UserInfoModelCopyWith(UserInfoModel value, $Res Function(UserInfoModel) _then) = _$UserInfoModelCopyWithImpl;
@useResult
$Res call({
 UserId id,@JsonKey(name: FirebaseFieldName.displayName) String? displayName, String? email,@JsonKey(name: FirebaseFieldName.profileImageUrl) String? profileImageUrl,@JsonKey(name: FirebaseFieldName.favoriteTracks) List<TrackId> favoriteTracks, UserRole role,@JsonKey(name: FirebaseFieldName.ownedTracks) List<TrackId> ownedTracks
});




}
/// @nodoc
class _$UserInfoModelCopyWithImpl<$Res>
    implements $UserInfoModelCopyWith<$Res> {
  _$UserInfoModelCopyWithImpl(this._self, this._then);

  final UserInfoModel _self;
  final $Res Function(UserInfoModel) _then;

/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? displayName = freezed,Object? email = freezed,Object? profileImageUrl = freezed,Object? favoriteTracks = null,Object? role = null,Object? ownedTracks = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as UserId,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,favoriteTracks: null == favoriteTracks ? _self.favoriteTracks : favoriteTracks // ignore: cast_nullable_to_non_nullable
as List<TrackId>,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,ownedTracks: null == ownedTracks ? _self.ownedTracks : ownedTracks // ignore: cast_nullable_to_non_nullable
as List<TrackId>,
  ));
}

}


/// Adds pattern-matching-related methods to [UserInfoModel].
extension UserInfoModelPatterns on UserInfoModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserInfoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserInfoModel value)  $default,){
final _that = this;
switch (_that) {
case _UserInfoModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserInfoModel value)?  $default,){
final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserId id, @JsonKey(name: FirebaseFieldName.displayName)  String? displayName,  String? email, @JsonKey(name: FirebaseFieldName.profileImageUrl)  String? profileImageUrl, @JsonKey(name: FirebaseFieldName.favoriteTracks)  List<TrackId> favoriteTracks,  UserRole role, @JsonKey(name: FirebaseFieldName.ownedTracks)  List<TrackId> ownedTracks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
return $default(_that.id,_that.displayName,_that.email,_that.profileImageUrl,_that.favoriteTracks,_that.role,_that.ownedTracks);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserId id, @JsonKey(name: FirebaseFieldName.displayName)  String? displayName,  String? email, @JsonKey(name: FirebaseFieldName.profileImageUrl)  String? profileImageUrl, @JsonKey(name: FirebaseFieldName.favoriteTracks)  List<TrackId> favoriteTracks,  UserRole role, @JsonKey(name: FirebaseFieldName.ownedTracks)  List<TrackId> ownedTracks)  $default,) {final _that = this;
switch (_that) {
case _UserInfoModel():
return $default(_that.id,_that.displayName,_that.email,_that.profileImageUrl,_that.favoriteTracks,_that.role,_that.ownedTracks);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserId id, @JsonKey(name: FirebaseFieldName.displayName)  String? displayName,  String? email, @JsonKey(name: FirebaseFieldName.profileImageUrl)  String? profileImageUrl, @JsonKey(name: FirebaseFieldName.favoriteTracks)  List<TrackId> favoriteTracks,  UserRole role, @JsonKey(name: FirebaseFieldName.ownedTracks)  List<TrackId> ownedTracks)?  $default,) {final _that = this;
switch (_that) {
case _UserInfoModel() when $default != null:
return $default(_that.id,_that.displayName,_that.email,_that.profileImageUrl,_that.favoriteTracks,_that.role,_that.ownedTracks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserInfoModel extends UserInfoModel {
  const _UserInfoModel({required this.id, @JsonKey(name: FirebaseFieldName.displayName) this.displayName = '', this.email = '', @JsonKey(name: FirebaseFieldName.profileImageUrl) this.profileImageUrl = '', @JsonKey(name: FirebaseFieldName.favoriteTracks) final  List<TrackId> favoriteTracks = const [], this.role = UserRole.guest, @JsonKey(name: FirebaseFieldName.ownedTracks) final  List<TrackId> ownedTracks = const []}): _favoriteTracks = favoriteTracks,_ownedTracks = ownedTracks,super._();
  factory _UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);

@override final  UserId id;
@override@JsonKey(name: FirebaseFieldName.displayName) final  String? displayName;
@override@JsonKey() final  String? email;
@override@JsonKey(name: FirebaseFieldName.profileImageUrl) final  String? profileImageUrl;
 final  List<TrackId> _favoriteTracks;
@override@JsonKey(name: FirebaseFieldName.favoriteTracks) List<TrackId> get favoriteTracks {
  if (_favoriteTracks is EqualUnmodifiableListView) return _favoriteTracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favoriteTracks);
}

@override@JsonKey() final  UserRole role;
 final  List<TrackId> _ownedTracks;
@override@JsonKey(name: FirebaseFieldName.ownedTracks) List<TrackId> get ownedTracks {
  if (_ownedTracks is EqualUnmodifiableListView) return _ownedTracks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedTracks);
}


/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserInfoModelCopyWith<_UserInfoModel> get copyWith => __$UserInfoModelCopyWithImpl<_UserInfoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserInfoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserInfoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.email, email) || other.email == email)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&const DeepCollectionEquality().equals(other._favoriteTracks, _favoriteTracks)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._ownedTracks, _ownedTracks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,displayName,email,profileImageUrl,const DeepCollectionEquality().hash(_favoriteTracks),role,const DeepCollectionEquality().hash(_ownedTracks));

@override
String toString() {
  return 'UserInfoModel(id: $id, displayName: $displayName, email: $email, profileImageUrl: $profileImageUrl, favoriteTracks: $favoriteTracks, role: $role, ownedTracks: $ownedTracks)';
}


}

/// @nodoc
abstract mixin class _$UserInfoModelCopyWith<$Res> implements $UserInfoModelCopyWith<$Res> {
  factory _$UserInfoModelCopyWith(_UserInfoModel value, $Res Function(_UserInfoModel) _then) = __$UserInfoModelCopyWithImpl;
@override @useResult
$Res call({
 UserId id,@JsonKey(name: FirebaseFieldName.displayName) String? displayName, String? email,@JsonKey(name: FirebaseFieldName.profileImageUrl) String? profileImageUrl,@JsonKey(name: FirebaseFieldName.favoriteTracks) List<TrackId> favoriteTracks, UserRole role,@JsonKey(name: FirebaseFieldName.ownedTracks) List<TrackId> ownedTracks
});




}
/// @nodoc
class __$UserInfoModelCopyWithImpl<$Res>
    implements _$UserInfoModelCopyWith<$Res> {
  __$UserInfoModelCopyWithImpl(this._self, this._then);

  final _UserInfoModel _self;
  final $Res Function(_UserInfoModel) _then;

/// Create a copy of UserInfoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? displayName = freezed,Object? email = freezed,Object? profileImageUrl = freezed,Object? favoriteTracks = null,Object? role = null,Object? ownedTracks = null,}) {
  return _then(_UserInfoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as UserId,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,favoriteTracks: null == favoriteTracks ? _self._favoriteTracks : favoriteTracks // ignore: cast_nullable_to_non_nullable
as List<TrackId>,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,ownedTracks: null == ownedTracks ? _self._ownedTracks : ownedTracks // ignore: cast_nullable_to_non_nullable
as List<TrackId>,
  ));
}


}

// dart format on

// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'track.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Track {

 TrackId get id;@JsonKey(name: FirebaseFieldName.trackName) String get trackName;@JsonKey(name: FirebaseFieldName.region) String get region;@JsonKey(name: FirebaseFieldName.location) String get location;@JsonKey(name: FirebaseFieldName.motoclub) String get motoclub;@JsonKey(name: FirebaseFieldName.category) String get category;@JsonKey(name: FirebaseFieldName.acceptedLicenses) List<TrackLicense> get acceptedLicenses;@JsonKey(name: FirebaseFieldName.terrainType) String get terrainType;@JsonKey(name: FirebaseFieldName.trackLength) String get trackLength;@JsonKey(name: FirebaseFieldName.hasMinicross) String get hasMinicross;@JsonKey(name: FirebaseFieldName.services) Map<String, String>? get services;@JsonKey(name: FirebaseFieldName.phones) List<String> get phones;@JsonKey(name: FirebaseFieldName.fax) List<String> get fax;@JsonKey(name: FirebaseFieldName.email) String get email;@JsonKey(name: FirebaseFieldName.website) String get website;@JsonKey(name: FirebaseFieldName.info) String get info;@JsonKey(name: FirebaseFieldName.latitude) String get latitude;@JsonKey(name: FirebaseFieldName.longitude) String get longitude;@JsonKey(name: FirebaseFieldName.photosUrl) String get photosUrl;@JsonKey(name: FirebaseFieldName.commentCount) int get commentCount;@JsonKey(name: FirebaseFieldName.rating) double get rating;
/// Create a copy of Track
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TrackCopyWith<Track> get copyWith => _$TrackCopyWithImpl<Track>(this as Track, _$identity);

  /// Serializes this Track to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Track&&(identical(other.id, id) || other.id == id)&&(identical(other.trackName, trackName) || other.trackName == trackName)&&(identical(other.region, region) || other.region == region)&&(identical(other.location, location) || other.location == location)&&(identical(other.motoclub, motoclub) || other.motoclub == motoclub)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other.acceptedLicenses, acceptedLicenses)&&(identical(other.terrainType, terrainType) || other.terrainType == terrainType)&&(identical(other.trackLength, trackLength) || other.trackLength == trackLength)&&(identical(other.hasMinicross, hasMinicross) || other.hasMinicross == hasMinicross)&&const DeepCollectionEquality().equals(other.services, services)&&const DeepCollectionEquality().equals(other.phones, phones)&&const DeepCollectionEquality().equals(other.fax, fax)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.info, info) || other.info == info)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.photosUrl, photosUrl) || other.photosUrl == photosUrl)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,trackName,region,location,motoclub,category,const DeepCollectionEquality().hash(acceptedLicenses),terrainType,trackLength,hasMinicross,const DeepCollectionEquality().hash(services),const DeepCollectionEquality().hash(phones),const DeepCollectionEquality().hash(fax),email,website,info,latitude,longitude,photosUrl,commentCount,rating]);

@override
String toString() {
  return 'Track(id: $id, trackName: $trackName, region: $region, location: $location, motoclub: $motoclub, category: $category, acceptedLicenses: $acceptedLicenses, terrainType: $terrainType, trackLength: $trackLength, hasMinicross: $hasMinicross, services: $services, phones: $phones, fax: $fax, email: $email, website: $website, info: $info, latitude: $latitude, longitude: $longitude, photosUrl: $photosUrl, commentCount: $commentCount, rating: $rating)';
}


}

/// @nodoc
abstract mixin class $TrackCopyWith<$Res>  {
  factory $TrackCopyWith(Track value, $Res Function(Track) _then) = _$TrackCopyWithImpl;
@useResult
$Res call({
 TrackId id,@JsonKey(name: FirebaseFieldName.trackName) String trackName,@JsonKey(name: FirebaseFieldName.region) String region,@JsonKey(name: FirebaseFieldName.location) String location,@JsonKey(name: FirebaseFieldName.motoclub) String motoclub,@JsonKey(name: FirebaseFieldName.category) String category,@JsonKey(name: FirebaseFieldName.acceptedLicenses) List<TrackLicense> acceptedLicenses,@JsonKey(name: FirebaseFieldName.terrainType) String terrainType,@JsonKey(name: FirebaseFieldName.trackLength) String trackLength,@JsonKey(name: FirebaseFieldName.hasMinicross) String hasMinicross,@JsonKey(name: FirebaseFieldName.services) Map<String, String>? services,@JsonKey(name: FirebaseFieldName.phones) List<String> phones,@JsonKey(name: FirebaseFieldName.fax) List<String> fax,@JsonKey(name: FirebaseFieldName.email) String email,@JsonKey(name: FirebaseFieldName.website) String website,@JsonKey(name: FirebaseFieldName.info) String info,@JsonKey(name: FirebaseFieldName.latitude) String latitude,@JsonKey(name: FirebaseFieldName.longitude) String longitude,@JsonKey(name: FirebaseFieldName.photosUrl) String photosUrl,@JsonKey(name: FirebaseFieldName.commentCount) int commentCount,@JsonKey(name: FirebaseFieldName.rating) double rating
});




}
/// @nodoc
class _$TrackCopyWithImpl<$Res>
    implements $TrackCopyWith<$Res> {
  _$TrackCopyWithImpl(this._self, this._then);

  final Track _self;
  final $Res Function(Track) _then;

/// Create a copy of Track
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? trackName = null,Object? region = null,Object? location = null,Object? motoclub = null,Object? category = null,Object? acceptedLicenses = null,Object? terrainType = null,Object? trackLength = null,Object? hasMinicross = null,Object? services = freezed,Object? phones = null,Object? fax = null,Object? email = null,Object? website = null,Object? info = null,Object? latitude = null,Object? longitude = null,Object? photosUrl = null,Object? commentCount = null,Object? rating = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as TrackId,trackName: null == trackName ? _self.trackName : trackName // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,motoclub: null == motoclub ? _self.motoclub : motoclub // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,acceptedLicenses: null == acceptedLicenses ? _self.acceptedLicenses : acceptedLicenses // ignore: cast_nullable_to_non_nullable
as List<TrackLicense>,terrainType: null == terrainType ? _self.terrainType : terrainType // ignore: cast_nullable_to_non_nullable
as String,trackLength: null == trackLength ? _self.trackLength : trackLength // ignore: cast_nullable_to_non_nullable
as String,hasMinicross: null == hasMinicross ? _self.hasMinicross : hasMinicross // ignore: cast_nullable_to_non_nullable
as String,services: freezed == services ? _self.services : services // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,phones: null == phones ? _self.phones : phones // ignore: cast_nullable_to_non_nullable
as List<String>,fax: null == fax ? _self.fax : fax // ignore: cast_nullable_to_non_nullable
as List<String>,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String,photosUrl: null == photosUrl ? _self.photosUrl : photosUrl // ignore: cast_nullable_to_non_nullable
as String,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [Track].
extension TrackPatterns on Track {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Track value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Track() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Track value)  $default,){
final _that = this;
switch (_that) {
case _Track():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Track value)?  $default,){
final _that = this;
switch (_that) {
case _Track() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( TrackId id, @JsonKey(name: FirebaseFieldName.trackName)  String trackName, @JsonKey(name: FirebaseFieldName.region)  String region, @JsonKey(name: FirebaseFieldName.location)  String location, @JsonKey(name: FirebaseFieldName.motoclub)  String motoclub, @JsonKey(name: FirebaseFieldName.category)  String category, @JsonKey(name: FirebaseFieldName.acceptedLicenses)  List<TrackLicense> acceptedLicenses, @JsonKey(name: FirebaseFieldName.terrainType)  String terrainType, @JsonKey(name: FirebaseFieldName.trackLength)  String trackLength, @JsonKey(name: FirebaseFieldName.hasMinicross)  String hasMinicross, @JsonKey(name: FirebaseFieldName.services)  Map<String, String>? services, @JsonKey(name: FirebaseFieldName.phones)  List<String> phones, @JsonKey(name: FirebaseFieldName.fax)  List<String> fax, @JsonKey(name: FirebaseFieldName.email)  String email, @JsonKey(name: FirebaseFieldName.website)  String website, @JsonKey(name: FirebaseFieldName.info)  String info, @JsonKey(name: FirebaseFieldName.latitude)  String latitude, @JsonKey(name: FirebaseFieldName.longitude)  String longitude, @JsonKey(name: FirebaseFieldName.photosUrl)  String photosUrl, @JsonKey(name: FirebaseFieldName.commentCount)  int commentCount, @JsonKey(name: FirebaseFieldName.rating)  double rating)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Track() when $default != null:
return $default(_that.id,_that.trackName,_that.region,_that.location,_that.motoclub,_that.category,_that.acceptedLicenses,_that.terrainType,_that.trackLength,_that.hasMinicross,_that.services,_that.phones,_that.fax,_that.email,_that.website,_that.info,_that.latitude,_that.longitude,_that.photosUrl,_that.commentCount,_that.rating);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( TrackId id, @JsonKey(name: FirebaseFieldName.trackName)  String trackName, @JsonKey(name: FirebaseFieldName.region)  String region, @JsonKey(name: FirebaseFieldName.location)  String location, @JsonKey(name: FirebaseFieldName.motoclub)  String motoclub, @JsonKey(name: FirebaseFieldName.category)  String category, @JsonKey(name: FirebaseFieldName.acceptedLicenses)  List<TrackLicense> acceptedLicenses, @JsonKey(name: FirebaseFieldName.terrainType)  String terrainType, @JsonKey(name: FirebaseFieldName.trackLength)  String trackLength, @JsonKey(name: FirebaseFieldName.hasMinicross)  String hasMinicross, @JsonKey(name: FirebaseFieldName.services)  Map<String, String>? services, @JsonKey(name: FirebaseFieldName.phones)  List<String> phones, @JsonKey(name: FirebaseFieldName.fax)  List<String> fax, @JsonKey(name: FirebaseFieldName.email)  String email, @JsonKey(name: FirebaseFieldName.website)  String website, @JsonKey(name: FirebaseFieldName.info)  String info, @JsonKey(name: FirebaseFieldName.latitude)  String latitude, @JsonKey(name: FirebaseFieldName.longitude)  String longitude, @JsonKey(name: FirebaseFieldName.photosUrl)  String photosUrl, @JsonKey(name: FirebaseFieldName.commentCount)  int commentCount, @JsonKey(name: FirebaseFieldName.rating)  double rating)  $default,) {final _that = this;
switch (_that) {
case _Track():
return $default(_that.id,_that.trackName,_that.region,_that.location,_that.motoclub,_that.category,_that.acceptedLicenses,_that.terrainType,_that.trackLength,_that.hasMinicross,_that.services,_that.phones,_that.fax,_that.email,_that.website,_that.info,_that.latitude,_that.longitude,_that.photosUrl,_that.commentCount,_that.rating);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( TrackId id, @JsonKey(name: FirebaseFieldName.trackName)  String trackName, @JsonKey(name: FirebaseFieldName.region)  String region, @JsonKey(name: FirebaseFieldName.location)  String location, @JsonKey(name: FirebaseFieldName.motoclub)  String motoclub, @JsonKey(name: FirebaseFieldName.category)  String category, @JsonKey(name: FirebaseFieldName.acceptedLicenses)  List<TrackLicense> acceptedLicenses, @JsonKey(name: FirebaseFieldName.terrainType)  String terrainType, @JsonKey(name: FirebaseFieldName.trackLength)  String trackLength, @JsonKey(name: FirebaseFieldName.hasMinicross)  String hasMinicross, @JsonKey(name: FirebaseFieldName.services)  Map<String, String>? services, @JsonKey(name: FirebaseFieldName.phones)  List<String> phones, @JsonKey(name: FirebaseFieldName.fax)  List<String> fax, @JsonKey(name: FirebaseFieldName.email)  String email, @JsonKey(name: FirebaseFieldName.website)  String website, @JsonKey(name: FirebaseFieldName.info)  String info, @JsonKey(name: FirebaseFieldName.latitude)  String latitude, @JsonKey(name: FirebaseFieldName.longitude)  String longitude, @JsonKey(name: FirebaseFieldName.photosUrl)  String photosUrl, @JsonKey(name: FirebaseFieldName.commentCount)  int commentCount, @JsonKey(name: FirebaseFieldName.rating)  double rating)?  $default,) {final _that = this;
switch (_that) {
case _Track() when $default != null:
return $default(_that.id,_that.trackName,_that.region,_that.location,_that.motoclub,_that.category,_that.acceptedLicenses,_that.terrainType,_that.trackLength,_that.hasMinicross,_that.services,_that.phones,_that.fax,_that.email,_that.website,_that.info,_that.latitude,_that.longitude,_that.photosUrl,_that.commentCount,_that.rating);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Track implements Track {
   _Track({this.id = '', @JsonKey(name: FirebaseFieldName.trackName) this.trackName = '', @JsonKey(name: FirebaseFieldName.region) this.region = '', @JsonKey(name: FirebaseFieldName.location) this.location = '', @JsonKey(name: FirebaseFieldName.motoclub) this.motoclub = '', @JsonKey(name: FirebaseFieldName.category) this.category = '', @JsonKey(name: FirebaseFieldName.acceptedLicenses) final  List<TrackLicense> acceptedLicenses = const [], @JsonKey(name: FirebaseFieldName.terrainType) this.terrainType = '', @JsonKey(name: FirebaseFieldName.trackLength) this.trackLength = '', @JsonKey(name: FirebaseFieldName.hasMinicross) this.hasMinicross = 'no', @JsonKey(name: FirebaseFieldName.services) final  Map<String, String>? services = const {}, @JsonKey(name: FirebaseFieldName.phones) final  List<String> phones = const [], @JsonKey(name: FirebaseFieldName.fax) final  List<String> fax = const [], @JsonKey(name: FirebaseFieldName.email) this.email = '', @JsonKey(name: FirebaseFieldName.website) this.website = '', @JsonKey(name: FirebaseFieldName.info) this.info = '', @JsonKey(name: FirebaseFieldName.latitude) this.latitude = '0.0', @JsonKey(name: FirebaseFieldName.longitude) this.longitude = '0.0', @JsonKey(name: FirebaseFieldName.photosUrl) this.photosUrl = '', @JsonKey(name: FirebaseFieldName.commentCount) this.commentCount = 0, @JsonKey(name: FirebaseFieldName.rating) this.rating = 0.0}): _acceptedLicenses = acceptedLicenses,_services = services,_phones = phones,_fax = fax;
  factory _Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);

@override@JsonKey() final  TrackId id;
@override@JsonKey(name: FirebaseFieldName.trackName) final  String trackName;
@override@JsonKey(name: FirebaseFieldName.region) final  String region;
@override@JsonKey(name: FirebaseFieldName.location) final  String location;
@override@JsonKey(name: FirebaseFieldName.motoclub) final  String motoclub;
@override@JsonKey(name: FirebaseFieldName.category) final  String category;
 final  List<TrackLicense> _acceptedLicenses;
@override@JsonKey(name: FirebaseFieldName.acceptedLicenses) List<TrackLicense> get acceptedLicenses {
  if (_acceptedLicenses is EqualUnmodifiableListView) return _acceptedLicenses;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_acceptedLicenses);
}

@override@JsonKey(name: FirebaseFieldName.terrainType) final  String terrainType;
@override@JsonKey(name: FirebaseFieldName.trackLength) final  String trackLength;
@override@JsonKey(name: FirebaseFieldName.hasMinicross) final  String hasMinicross;
 final  Map<String, String>? _services;
@override@JsonKey(name: FirebaseFieldName.services) Map<String, String>? get services {
  final value = _services;
  if (value == null) return null;
  if (_services is EqualUnmodifiableMapView) return _services;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

 final  List<String> _phones;
@override@JsonKey(name: FirebaseFieldName.phones) List<String> get phones {
  if (_phones is EqualUnmodifiableListView) return _phones;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_phones);
}

 final  List<String> _fax;
@override@JsonKey(name: FirebaseFieldName.fax) List<String> get fax {
  if (_fax is EqualUnmodifiableListView) return _fax;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_fax);
}

@override@JsonKey(name: FirebaseFieldName.email) final  String email;
@override@JsonKey(name: FirebaseFieldName.website) final  String website;
@override@JsonKey(name: FirebaseFieldName.info) final  String info;
@override@JsonKey(name: FirebaseFieldName.latitude) final  String latitude;
@override@JsonKey(name: FirebaseFieldName.longitude) final  String longitude;
@override@JsonKey(name: FirebaseFieldName.photosUrl) final  String photosUrl;
@override@JsonKey(name: FirebaseFieldName.commentCount) final  int commentCount;
@override@JsonKey(name: FirebaseFieldName.rating) final  double rating;

/// Create a copy of Track
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TrackCopyWith<_Track> get copyWith => __$TrackCopyWithImpl<_Track>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TrackToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Track&&(identical(other.id, id) || other.id == id)&&(identical(other.trackName, trackName) || other.trackName == trackName)&&(identical(other.region, region) || other.region == region)&&(identical(other.location, location) || other.location == location)&&(identical(other.motoclub, motoclub) || other.motoclub == motoclub)&&(identical(other.category, category) || other.category == category)&&const DeepCollectionEquality().equals(other._acceptedLicenses, _acceptedLicenses)&&(identical(other.terrainType, terrainType) || other.terrainType == terrainType)&&(identical(other.trackLength, trackLength) || other.trackLength == trackLength)&&(identical(other.hasMinicross, hasMinicross) || other.hasMinicross == hasMinicross)&&const DeepCollectionEquality().equals(other._services, _services)&&const DeepCollectionEquality().equals(other._phones, _phones)&&const DeepCollectionEquality().equals(other._fax, _fax)&&(identical(other.email, email) || other.email == email)&&(identical(other.website, website) || other.website == website)&&(identical(other.info, info) || other.info == info)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.photosUrl, photosUrl) || other.photosUrl == photosUrl)&&(identical(other.commentCount, commentCount) || other.commentCount == commentCount)&&(identical(other.rating, rating) || other.rating == rating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,trackName,region,location,motoclub,category,const DeepCollectionEquality().hash(_acceptedLicenses),terrainType,trackLength,hasMinicross,const DeepCollectionEquality().hash(_services),const DeepCollectionEquality().hash(_phones),const DeepCollectionEquality().hash(_fax),email,website,info,latitude,longitude,photosUrl,commentCount,rating]);

@override
String toString() {
  return 'Track(id: $id, trackName: $trackName, region: $region, location: $location, motoclub: $motoclub, category: $category, acceptedLicenses: $acceptedLicenses, terrainType: $terrainType, trackLength: $trackLength, hasMinicross: $hasMinicross, services: $services, phones: $phones, fax: $fax, email: $email, website: $website, info: $info, latitude: $latitude, longitude: $longitude, photosUrl: $photosUrl, commentCount: $commentCount, rating: $rating)';
}


}

/// @nodoc
abstract mixin class _$TrackCopyWith<$Res> implements $TrackCopyWith<$Res> {
  factory _$TrackCopyWith(_Track value, $Res Function(_Track) _then) = __$TrackCopyWithImpl;
@override @useResult
$Res call({
 TrackId id,@JsonKey(name: FirebaseFieldName.trackName) String trackName,@JsonKey(name: FirebaseFieldName.region) String region,@JsonKey(name: FirebaseFieldName.location) String location,@JsonKey(name: FirebaseFieldName.motoclub) String motoclub,@JsonKey(name: FirebaseFieldName.category) String category,@JsonKey(name: FirebaseFieldName.acceptedLicenses) List<TrackLicense> acceptedLicenses,@JsonKey(name: FirebaseFieldName.terrainType) String terrainType,@JsonKey(name: FirebaseFieldName.trackLength) String trackLength,@JsonKey(name: FirebaseFieldName.hasMinicross) String hasMinicross,@JsonKey(name: FirebaseFieldName.services) Map<String, String>? services,@JsonKey(name: FirebaseFieldName.phones) List<String> phones,@JsonKey(name: FirebaseFieldName.fax) List<String> fax,@JsonKey(name: FirebaseFieldName.email) String email,@JsonKey(name: FirebaseFieldName.website) String website,@JsonKey(name: FirebaseFieldName.info) String info,@JsonKey(name: FirebaseFieldName.latitude) String latitude,@JsonKey(name: FirebaseFieldName.longitude) String longitude,@JsonKey(name: FirebaseFieldName.photosUrl) String photosUrl,@JsonKey(name: FirebaseFieldName.commentCount) int commentCount,@JsonKey(name: FirebaseFieldName.rating) double rating
});




}
/// @nodoc
class __$TrackCopyWithImpl<$Res>
    implements _$TrackCopyWith<$Res> {
  __$TrackCopyWithImpl(this._self, this._then);

  final _Track _self;
  final $Res Function(_Track) _then;

/// Create a copy of Track
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? trackName = null,Object? region = null,Object? location = null,Object? motoclub = null,Object? category = null,Object? acceptedLicenses = null,Object? terrainType = null,Object? trackLength = null,Object? hasMinicross = null,Object? services = freezed,Object? phones = null,Object? fax = null,Object? email = null,Object? website = null,Object? info = null,Object? latitude = null,Object? longitude = null,Object? photosUrl = null,Object? commentCount = null,Object? rating = null,}) {
  return _then(_Track(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as TrackId,trackName: null == trackName ? _self.trackName : trackName // ignore: cast_nullable_to_non_nullable
as String,region: null == region ? _self.region : region // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,motoclub: null == motoclub ? _self.motoclub : motoclub // ignore: cast_nullable_to_non_nullable
as String,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,acceptedLicenses: null == acceptedLicenses ? _self._acceptedLicenses : acceptedLicenses // ignore: cast_nullable_to_non_nullable
as List<TrackLicense>,terrainType: null == terrainType ? _self.terrainType : terrainType // ignore: cast_nullable_to_non_nullable
as String,trackLength: null == trackLength ? _self.trackLength : trackLength // ignore: cast_nullable_to_non_nullable
as String,hasMinicross: null == hasMinicross ? _self.hasMinicross : hasMinicross // ignore: cast_nullable_to_non_nullable
as String,services: freezed == services ? _self._services : services // ignore: cast_nullable_to_non_nullable
as Map<String, String>?,phones: null == phones ? _self._phones : phones // ignore: cast_nullable_to_non_nullable
as List<String>,fax: null == fax ? _self._fax : fax // ignore: cast_nullable_to_non_nullable
as List<String>,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,info: null == info ? _self.info : info // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as String,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as String,photosUrl: null == photosUrl ? _self.photosUrl : photosUrl // ignore: cast_nullable_to_non_nullable
as String,commentCount: null == commentCount ? _self.commentCount : commentCount // ignore: cast_nullable_to_non_nullable
as int,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on

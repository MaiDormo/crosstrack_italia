// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherInfo {

 String get date; String get iconUrl; String get temperature; String get weatherCondition;
/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherInfoCopyWith<WeatherInfo> get copyWith => _$WeatherInfoCopyWithImpl<WeatherInfo>(this as WeatherInfo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherInfo&&(identical(other.date, date) || other.date == date)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherCondition, weatherCondition) || other.weatherCondition == weatherCondition));
}


@override
int get hashCode => Object.hash(runtimeType,date,iconUrl,temperature,weatherCondition);

@override
String toString() {
  return 'WeatherInfo(date: $date, iconUrl: $iconUrl, temperature: $temperature, weatherCondition: $weatherCondition)';
}


}

/// @nodoc
abstract mixin class $WeatherInfoCopyWith<$Res>  {
  factory $WeatherInfoCopyWith(WeatherInfo value, $Res Function(WeatherInfo) _then) = _$WeatherInfoCopyWithImpl;
@useResult
$Res call({
 String date, String iconUrl, String temperature, String weatherCondition
});




}
/// @nodoc
class _$WeatherInfoCopyWithImpl<$Res>
    implements $WeatherInfoCopyWith<$Res> {
  _$WeatherInfoCopyWithImpl(this._self, this._then);

  final WeatherInfo _self;
  final $Res Function(WeatherInfo) _then;

/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? iconUrl = null,Object? temperature = null,Object? weatherCondition = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,iconUrl: null == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as String,weatherCondition: null == weatherCondition ? _self.weatherCondition : weatherCondition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherInfo].
extension WeatherInfoPatterns on WeatherInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherInfo value)  $default,){
final _that = this;
switch (_that) {
case _WeatherInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherInfo value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String date,  String iconUrl,  String temperature,  String weatherCondition)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
return $default(_that.date,_that.iconUrl,_that.temperature,_that.weatherCondition);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String date,  String iconUrl,  String temperature,  String weatherCondition)  $default,) {final _that = this;
switch (_that) {
case _WeatherInfo():
return $default(_that.date,_that.iconUrl,_that.temperature,_that.weatherCondition);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String date,  String iconUrl,  String temperature,  String weatherCondition)?  $default,) {final _that = this;
switch (_that) {
case _WeatherInfo() when $default != null:
return $default(_that.date,_that.iconUrl,_that.temperature,_that.weatherCondition);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherInfo implements WeatherInfo {
   _WeatherInfo({required this.date, required this.iconUrl, required this.temperature, required this.weatherCondition});
  

@override final  String date;
@override final  String iconUrl;
@override final  String temperature;
@override final  String weatherCondition;

/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherInfoCopyWith<_WeatherInfo> get copyWith => __$WeatherInfoCopyWithImpl<_WeatherInfo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherInfo&&(identical(other.date, date) || other.date == date)&&(identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.weatherCondition, weatherCondition) || other.weatherCondition == weatherCondition));
}


@override
int get hashCode => Object.hash(runtimeType,date,iconUrl,temperature,weatherCondition);

@override
String toString() {
  return 'WeatherInfo(date: $date, iconUrl: $iconUrl, temperature: $temperature, weatherCondition: $weatherCondition)';
}


}

/// @nodoc
abstract mixin class _$WeatherInfoCopyWith<$Res> implements $WeatherInfoCopyWith<$Res> {
  factory _$WeatherInfoCopyWith(_WeatherInfo value, $Res Function(_WeatherInfo) _then) = __$WeatherInfoCopyWithImpl;
@override @useResult
$Res call({
 String date, String iconUrl, String temperature, String weatherCondition
});




}
/// @nodoc
class __$WeatherInfoCopyWithImpl<$Res>
    implements _$WeatherInfoCopyWith<$Res> {
  __$WeatherInfoCopyWithImpl(this._self, this._then);

  final _WeatherInfo _self;
  final $Res Function(_WeatherInfo) _then;

/// Create a copy of WeatherInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? iconUrl = null,Object? temperature = null,Object? weatherCondition = null,}) {
  return _then(_WeatherInfo(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as String,iconUrl: null == iconUrl ? _self.iconUrl : iconUrl // ignore: cast_nullable_to_non_nullable
as String,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as String,weatherCondition: null == weatherCondition ? _self.weatherCondition : weatherCondition // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on

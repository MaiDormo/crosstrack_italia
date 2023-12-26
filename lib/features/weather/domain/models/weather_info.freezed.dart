// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$WeatherInfo {
  String get date => throw _privateConstructorUsedError;
  String get iconUrl => throw _privateConstructorUsedError;
  String get temperature => throw _privateConstructorUsedError;
  String get weatherCondition => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $WeatherInfoCopyWith<WeatherInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherInfoCopyWith<$Res> {
  factory $WeatherInfoCopyWith(
          WeatherInfo value, $Res Function(WeatherInfo) then) =
      _$WeatherInfoCopyWithImpl<$Res, WeatherInfo>;
  @useResult
  $Res call(
      {String date,
      String iconUrl,
      String temperature,
      String weatherCondition});
}

/// @nodoc
class _$WeatherInfoCopyWithImpl<$Res, $Val extends WeatherInfo>
    implements $WeatherInfoCopyWith<$Res> {
  _$WeatherInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? iconUrl = null,
    Object? temperature = null,
    Object? weatherCondition = null,
  }) {
    return _then(_value.copyWith(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String,
      weatherCondition: null == weatherCondition
          ? _value.weatherCondition
          : weatherCondition // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherInfoImplCopyWith<$Res>
    implements $WeatherInfoCopyWith<$Res> {
  factory _$$WeatherInfoImplCopyWith(
          _$WeatherInfoImpl value, $Res Function(_$WeatherInfoImpl) then) =
      __$$WeatherInfoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String date,
      String iconUrl,
      String temperature,
      String weatherCondition});
}

/// @nodoc
class __$$WeatherInfoImplCopyWithImpl<$Res>
    extends _$WeatherInfoCopyWithImpl<$Res, _$WeatherInfoImpl>
    implements _$$WeatherInfoImplCopyWith<$Res> {
  __$$WeatherInfoImplCopyWithImpl(
      _$WeatherInfoImpl _value, $Res Function(_$WeatherInfoImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? date = null,
    Object? iconUrl = null,
    Object? temperature = null,
    Object? weatherCondition = null,
  }) {
    return _then(_$WeatherInfoImpl(
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      iconUrl: null == iconUrl
          ? _value.iconUrl
          : iconUrl // ignore: cast_nullable_to_non_nullable
              as String,
      temperature: null == temperature
          ? _value.temperature
          : temperature // ignore: cast_nullable_to_non_nullable
              as String,
      weatherCondition: null == weatherCondition
          ? _value.weatherCondition
          : weatherCondition // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$WeatherInfoImpl implements _WeatherInfo {
  _$WeatherInfoImpl(
      {required this.date,
      required this.iconUrl,
      required this.temperature,
      required this.weatherCondition});

  @override
  final String date;
  @override
  final String iconUrl;
  @override
  final String temperature;
  @override
  final String weatherCondition;

  @override
  String toString() {
    return 'WeatherInfo(date: $date, iconUrl: $iconUrl, temperature: $temperature, weatherCondition: $weatherCondition)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherInfoImpl &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.iconUrl, iconUrl) || other.iconUrl == iconUrl) &&
            (identical(other.temperature, temperature) ||
                other.temperature == temperature) &&
            (identical(other.weatherCondition, weatherCondition) ||
                other.weatherCondition == weatherCondition));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, date, iconUrl, temperature, weatherCondition);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherInfoImplCopyWith<_$WeatherInfoImpl> get copyWith =>
      __$$WeatherInfoImplCopyWithImpl<_$WeatherInfoImpl>(this, _$identity);
}

abstract class _WeatherInfo implements WeatherInfo {
  factory _WeatherInfo(
      {required final String date,
      required final String iconUrl,
      required final String temperature,
      required final String weatherCondition}) = _$WeatherInfoImpl;

  @override
  String get date;
  @override
  String get iconUrl;
  @override
  String get temperature;
  @override
  String get weatherCondition;
  @override
  @JsonKey(ignore: true)
  _$$WeatherInfoImplCopyWith<_$WeatherInfoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

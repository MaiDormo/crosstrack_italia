// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_forecast_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherInfoForecastHash() =>
    r'541dc67afba63d2b6c918aab036b9084b0daa627';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef WeatherInfoForecastRef = AutoDisposeFutureProviderRef<List<Weather>>;

/// See also [weatherInfoForecast].
@ProviderFor(weatherInfoForecast)
const weatherInfoForecastProvider = WeatherInfoForecastFamily();

/// See also [weatherInfoForecast].
class WeatherInfoForecastFamily extends Family<AsyncValue<List<Weather>>> {
  /// See also [weatherInfoForecast].
  const WeatherInfoForecastFamily();

  /// See also [weatherInfoForecast].
  WeatherInfoForecastProvider call(
    LatLng location,
  ) {
    return WeatherInfoForecastProvider(
      location,
    );
  }

  @override
  WeatherInfoForecastProvider getProviderOverride(
    covariant WeatherInfoForecastProvider provider,
  ) {
    return call(
      provider.location,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'weatherInfoForecastProvider';
}

/// See also [weatherInfoForecast].
class WeatherInfoForecastProvider
    extends AutoDisposeFutureProvider<List<Weather>> {
  /// See also [weatherInfoForecast].
  WeatherInfoForecastProvider(
    this.location,
  ) : super.internal(
          (ref) => weatherInfoForecast(
            ref,
            location,
          ),
          from: weatherInfoForecastProvider,
          name: r'weatherInfoForecastProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weatherInfoForecastHash,
          dependencies: WeatherInfoForecastFamily._dependencies,
          allTransitiveDependencies:
              WeatherInfoForecastFamily._allTransitiveDependencies,
        );

  final LatLng location;

  @override
  bool operator ==(Object other) {
    return other is WeatherInfoForecastProvider && other.location == location;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, location.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member

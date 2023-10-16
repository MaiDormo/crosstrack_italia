// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_info_current_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$weatherInfoCurrentHash() =>
    r'277050b20d9d771264142738eb92326d476a95a4';

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

typedef WeatherInfoCurrentRef = AutoDisposeFutureProviderRef<Weather>;

/// See also [weatherInfoCurrent].
@ProviderFor(weatherInfoCurrent)
const weatherInfoCurrentProvider = WeatherInfoCurrentFamily();

/// See also [weatherInfoCurrent].
class WeatherInfoCurrentFamily extends Family<AsyncValue<Weather>> {
  /// See also [weatherInfoCurrent].
  const WeatherInfoCurrentFamily();

  /// See also [weatherInfoCurrent].
  WeatherInfoCurrentProvider call(
    LatLng location,
  ) {
    return WeatherInfoCurrentProvider(
      location,
    );
  }

  @override
  WeatherInfoCurrentProvider getProviderOverride(
    covariant WeatherInfoCurrentProvider provider,
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
  String? get name => r'weatherInfoCurrentProvider';
}

/// See also [weatherInfoCurrent].
class WeatherInfoCurrentProvider extends AutoDisposeFutureProvider<Weather> {
  /// See also [weatherInfoCurrent].
  WeatherInfoCurrentProvider(
    this.location,
  ) : super.internal(
          (ref) => weatherInfoCurrent(
            ref,
            location,
          ),
          from: weatherInfoCurrentProvider,
          name: r'weatherInfoCurrentProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$weatherInfoCurrentHash,
          dependencies: WeatherInfoCurrentFamily._dependencies,
          allTransitiveDependencies:
              WeatherInfoCurrentFamily._allTransitiveDependencies,
        );

  final LatLng location;

  @override
  bool operator ==(Object other) {
    return other is WeatherInfoCurrentProvider && other.location == location;
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

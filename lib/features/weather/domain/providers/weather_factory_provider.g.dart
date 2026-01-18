// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_factory_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(weatherFactory)
final weatherFactoryProvider = WeatherFactoryProvider._();

final class WeatherFactoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<WeatherFactory>,
          WeatherFactory,
          FutureOr<WeatherFactory>
        >
    with $FutureModifier<WeatherFactory>, $FutureProvider<WeatherFactory> {
  WeatherFactoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weatherFactoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weatherFactoryHash();

  @$internal
  @override
  $FutureProviderElement<WeatherFactory> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<WeatherFactory> create(Ref ref) {
    return weatherFactory(ref);
  }
}

String _$weatherFactoryHash() => r'4a4a44f3a286f28ee9df402870d091c426dd0f8c';

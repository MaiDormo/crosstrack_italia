// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forecast_info_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(forecastInfo)
final forecastInfoProvider = ForecastInfoProvider._();

final class ForecastInfoProvider
    extends
        $FunctionalProvider<
          AsyncValue<Forecast?>,
          Forecast?,
          FutureOr<Forecast?>
        >
    with $FutureModifier<Forecast?>, $FutureProvider<Forecast?> {
  ForecastInfoProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'forecastInfoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$forecastInfoHash();

  @$internal
  @override
  $FutureProviderElement<Forecast?> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Forecast?> create(Ref ref) {
    return forecastInfo(ref);
  }
}

String _$forecastInfoHash() => r'5436381e4267b615898083178086b87fc0549da5';

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floating_searching_bar_utils.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedRegion)
final selectedRegionProvider = SelectedRegionProvider._();

final class SelectedRegionProvider
    extends $NotifierProvider<SelectedRegion, Regions> {
  SelectedRegionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedRegionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedRegionHash();

  @$internal
  @override
  SelectedRegion create() => SelectedRegion();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Regions value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Regions>(value),
    );
  }
}

String _$selectedRegionHash() => r'8f2285ee7e360168a0d6e84b24fec1889bda7223';

abstract class _$SelectedRegion extends $Notifier<Regions> {
  Regions build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Regions, Regions>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Regions, Regions>,
              Regions,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(SearchTrackString)
final searchTrackStringProvider = SearchTrackStringProvider._();

final class SearchTrackStringProvider
    extends $NotifierProvider<SearchTrackString, String> {
  SearchTrackStringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchTrackStringProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchTrackStringHash();

  @$internal
  @override
  SearchTrackString create() => SearchTrackString();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchTrackStringHash() => r'9b4cdc6a5adc3852c3189ee90337cb15b54e9138';

abstract class _$SearchTrackString extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

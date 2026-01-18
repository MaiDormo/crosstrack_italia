// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_track_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SearchTrack)
final searchTrackProvider = SearchTrackProvider._();

final class SearchTrackProvider
    extends $NotifierProvider<SearchTrack, List<dynamic>> {
  SearchTrackProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'searchTrackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$searchTrackHash();

  @$internal
  @override
  SearchTrack create() => SearchTrack();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<dynamic> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<dynamic>>(value),
    );
  }
}

String _$searchTrackHash() => r'82220f3166aab6d62bed12f61d80a8e7b990f7dd';

abstract class _$SearchTrack extends $Notifier<List<dynamic>> {
  List<dynamic> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<dynamic>, List<dynamic>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<dynamic>, List<dynamic>>,
              List<dynamic>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

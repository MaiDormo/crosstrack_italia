// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_selector.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(SelectedTracks)
final selectedTracksProvider = SelectedTracksProvider._();

final class SelectedTracksProvider
    extends $NotifierProvider<SelectedTracks, List<Track?>> {
  SelectedTracksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'selectedTracksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$selectedTracksHash();

  @$internal
  @override
  SelectedTracks create() => SelectedTracks();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Track?> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Track?>>(value),
    );
  }
}

String _$selectedTracksHash() => r'6d7312a951449dea48e2d8ab652712be2e822214';

abstract class _$SelectedTracks extends $Notifier<List<Track?>> {
  List<Track?> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Track?>, List<Track?>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<Track?>, List<Track?>>,
              List<Track?>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

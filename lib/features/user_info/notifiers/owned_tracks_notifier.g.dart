// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ownedTracksRepository)
final ownedTracksRepositoryProvider = OwnedTracksRepositoryProvider._();

final class OwnedTracksRepositoryProvider
    extends
        $FunctionalProvider<
          OwnedTracksRepository,
          OwnedTracksRepository,
          OwnedTracksRepository
        >
    with $Provider<OwnedTracksRepository> {
  OwnedTracksRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownedTracksRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownedTracksRepositoryHash();

  @$internal
  @override
  $ProviderElement<OwnedTracksRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OwnedTracksRepository create(Ref ref) {
    return ownedTracksRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OwnedTracksRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OwnedTracksRepository>(value),
    );
  }
}

String _$ownedTracksRepositoryHash() =>
    r'4ff29180ca4e3bd93e9379760a6f45b6019fa61f';

@ProviderFor(OwnedTracksNotifier)
final ownedTracksProvider = OwnedTracksNotifierProvider._();

final class OwnedTracksNotifierProvider
    extends $AsyncNotifierProvider<OwnedTracksNotifier, List<TrackId>> {
  OwnedTracksNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'ownedTracksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$ownedTracksNotifierHash();

  @$internal
  @override
  OwnedTracksNotifier create() => OwnedTracksNotifier();
}

String _$ownedTracksNotifierHash() =>
    r'48b3a38a5d56f5e4a867f923b3907d255f54cac4';

abstract class _$OwnedTracksNotifier extends $AsyncNotifier<List<TrackId>> {
  FutureOr<List<TrackId>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<TrackId>>, List<TrackId>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<TrackId>>, List<TrackId>>,
              AsyncValue<List<TrackId>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

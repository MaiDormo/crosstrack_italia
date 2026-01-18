// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(favoriteTracksRepository)
final favoriteTracksRepositoryProvider = FavoriteTracksRepositoryProvider._();

final class FavoriteTracksRepositoryProvider
    extends
        $FunctionalProvider<
          FavoriteTracksRepository,
          FavoriteTracksRepository,
          FavoriteTracksRepository
        >
    with $Provider<FavoriteTracksRepository> {
  FavoriteTracksRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteTracksRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteTracksRepositoryHash();

  @$internal
  @override
  $ProviderElement<FavoriteTracksRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FavoriteTracksRepository create(Ref ref) {
    return favoriteTracksRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FavoriteTracksRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FavoriteTracksRepository>(value),
    );
  }
}

String _$favoriteTracksRepositoryHash() =>
    r'56ea42e35a42cb8a0a85df9c3f36bdd20084bd18';

@ProviderFor(FavoriteTracksNotifier)
final favoriteTracksProvider = FavoriteTracksNotifierProvider._();

final class FavoriteTracksNotifierProvider
    extends $AsyncNotifierProvider<FavoriteTracksNotifier, List<TrackId>> {
  FavoriteTracksNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoriteTracksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoriteTracksNotifierHash();

  @$internal
  @override
  FavoriteTracksNotifier create() => FavoriteTracksNotifier();
}

String _$favoriteTracksNotifierHash() =>
    r'05e08361e655524f896b9efdc32ab16544bf2d63';

abstract class _$FavoriteTracksNotifier extends $AsyncNotifier<List<TrackId>> {
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

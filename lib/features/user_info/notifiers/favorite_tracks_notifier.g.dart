// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteTracksRepositoryHash() =>
    r'87e4135e5fa857fafc7956525613b94f1a0ca5e0';

/// See also [favoriteTracksRepository].
@ProviderFor(favoriteTracksRepository)
final favoriteTracksRepositoryProvider =
    AutoDisposeProvider<FavoriteTracksRepository>.internal(
  favoriteTracksRepository,
  name: r'favoriteTracksRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteTracksRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteTracksRepositoryRef
    = AutoDisposeProviderRef<FavoriteTracksRepository>;
String _$favoriteTracksNotifierHash() =>
    r'05e08361e655524f896b9efdc32ab16544bf2d63';

/// See also [FavoriteTracksNotifier].
@ProviderFor(FavoriteTracksNotifier)
final favoriteTracksNotifierProvider = AutoDisposeAsyncNotifierProvider<
    FavoriteTracksNotifier, List<TrackId>>.internal(
  FavoriteTracksNotifier.new,
  name: r'favoriteTracksNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteTracksNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$FavoriteTracksNotifier = AutoDisposeAsyncNotifier<List<TrackId>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

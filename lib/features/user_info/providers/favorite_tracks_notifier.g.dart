// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$favoriteTracksServiceHash() =>
    r'00557d5c3d55eca082e500ec55af22cc1e6e4cfb';

/// See also [favoriteTracksService].
@ProviderFor(favoriteTracksService)
final favoriteTracksServiceProvider =
    AutoDisposeProvider<FavoriteTracksService>.internal(
  favoriteTracksService,
  name: r'favoriteTracksServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$favoriteTracksServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FavoriteTracksServiceRef
    = AutoDisposeProviderRef<FavoriteTracksService>;
String _$favoriteTracksNotifierHash() =>
    r'de7c4a0851b4f56400a5a8106a63c373d829ca48';

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

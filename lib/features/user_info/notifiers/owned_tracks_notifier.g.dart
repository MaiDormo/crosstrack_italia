// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ownedTracksRepositoryHash() =>
    r'd427b15a13c16a366855136edcceb351c32195cb';

/// See also [ownedTracksRepository].
@ProviderFor(ownedTracksRepository)
final ownedTracksRepositoryProvider =
    AutoDisposeProvider<OwnedTracksRepository>.internal(
  ownedTracksRepository,
  name: r'ownedTracksRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ownedTracksRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OwnedTracksRepositoryRef
    = AutoDisposeProviderRef<OwnedTracksRepository>;
String _$ownedTracksNotifierHash() =>
    r'48b3a38a5d56f5e4a867f923b3907d255f54cac4';

/// See also [OwnedTracksNotifier].
@ProviderFor(OwnedTracksNotifier)
final ownedTracksNotifierProvider = AutoDisposeAsyncNotifierProvider<
    OwnedTracksNotifier, List<TrackId>>.internal(
  OwnedTracksNotifier.new,
  name: r'ownedTracksNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ownedTracksNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OwnedTracksNotifier = AutoDisposeAsyncNotifier<List<TrackId>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

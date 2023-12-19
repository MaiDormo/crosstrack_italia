// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ownedTracksServiceHash() =>
    r'71077ed29169801dc6fa6a4df341d86939f45d48';

/// See also [ownedTracksService].
@ProviderFor(ownedTracksService)
final ownedTracksServiceProvider =
    AutoDisposeProvider<OwnedTracksService>.internal(
  ownedTracksService,
  name: r'ownedTracksServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ownedTracksServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef OwnedTracksServiceRef = AutoDisposeProviderRef<OwnedTracksService>;
String _$ownedTracksNotifierHash() =>
    r'2aa65c503b3833f2a984d3ebdb8fb87bffa809be';

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

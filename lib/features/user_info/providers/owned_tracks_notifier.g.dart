// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_tracks_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$ownedTracksServiceHash() =>
    r'aea68b70ca86e333f4ce53aaa5ff00985cb1d3b1';

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
    r'eed543b760856382b41a92abdbe2a73e161f9ed9';

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

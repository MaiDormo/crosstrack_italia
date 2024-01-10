// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getLocationPlaceStringHash() =>
    r'9c1f4e4859cc878bbead7f07c949d5d9f295d38d';

/// See also [getLocationPlaceString].
@ProviderFor(getLocationPlaceString)
final getLocationPlaceStringProvider =
    AutoDisposeFutureProvider<String>.internal(
  getLocationPlaceString,
  name: r'getLocationPlaceStringProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getLocationPlaceStringHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetLocationPlaceStringRef = AutoDisposeFutureProviderRef<String>;
String _$getPositionHash() => r'0ad6cb4df7221036b06b8258a6568c403e4255ca';

/// See also [getPosition].
@ProviderFor(getPosition)
final getPositionProvider = AutoDisposeFutureProvider<Position?>.internal(
  getPosition,
  name: r'getPositionProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getPositionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetPositionRef = AutoDisposeFutureProviderRef<Position?>;
String _$showCurrentLocationHash() =>
    r'55be9755ecab2a7bbf0bdb32305ada517759f536';

/// See also [ShowCurrentLocation].
@ProviderFor(ShowCurrentLocation)
final showCurrentLocationProvider =
    AutoDisposeNotifierProvider<ShowCurrentLocation, bool>.internal(
  ShowCurrentLocation.new,
  name: r'showCurrentLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$showCurrentLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ShowCurrentLocation = AutoDisposeNotifier<bool>;
String _$centerUserLocationHash() =>
    r'bd528824bd4550efb6c347abf9ae86152f9fbce7';

/// See also [CenterUserLocation].
@ProviderFor(CenterUserLocation)
final centerUserLocationProvider = AutoDisposeNotifierProvider<
    CenterUserLocation, FollowOnLocationUpdate>.internal(
  CenterUserLocation.new,
  name: r'centerUserLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$centerUserLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CenterUserLocation = AutoDisposeNotifier<FollowOnLocationUpdate>;
String _$userLocationNotifierHash() =>
    r'5ffeac77f90d87d926c0b3e669ee1209ee5646b7';

/// See also [UserLocationNotifier].
@ProviderFor(UserLocationNotifier)
final userLocationNotifierProvider =
    AutoDisposeNotifierProvider<UserLocationNotifier, void>.internal(
  UserLocationNotifier.new,
  name: r'userLocationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLocationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLocationNotifier = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

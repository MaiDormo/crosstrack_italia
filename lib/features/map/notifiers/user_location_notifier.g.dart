// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getClosestLocationHash() =>
    r'07c96e1dd59ee7d9c598507835748f6e6479de36';

/// See also [getClosestLocation].
@ProviderFor(getClosestLocation)
final getClosestLocationProvider = AutoDisposeFutureProvider<String>.internal(
  getClosestLocation,
  name: r'getClosestLocationProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getClosestLocationHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetClosestLocationRef = AutoDisposeFutureProviderRef<String>;
String _$getPositionHash() => r'8bf0a50952322fd2ad61e5e990e945d9a71ce28a';

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
String _$locationServicesHash() => r'1df801ed86cbc084190d7f8e8d82b73bcf895f9a';

/// See also [LocationServices].
@ProviderFor(LocationServices)
final locationServicesProvider =
    AutoDisposeNotifierProvider<LocationServices, bool>.internal(
  LocationServices.new,
  name: r'locationServicesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationServicesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocationServices = AutoDisposeNotifier<bool>;
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
    r'd49ec51dc585ef0e428d33337c0faf64c8f0127a';

/// See also [UserLocationNotifier].
@ProviderFor(UserLocationNotifier)
final userLocationNotifierProvider =
    AutoDisposeNotifierProvider<UserLocationNotifier, bool>.internal(
  UserLocationNotifier.new,
  name: r'userLocationNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$userLocationNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$UserLocationNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

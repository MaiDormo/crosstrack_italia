// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_permission_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$locationPermissionHash() =>
    r'63aa10056974aa8015387e726685fac816db8f01';

/// See also [LocationPermission].
@ProviderFor(LocationPermission)
final locationPermissionProvider =
    AutoDisposeNotifierProvider<LocationPermission, bool>.internal(
  LocationPermission.new,
  name: r'locationPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$locationPermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$LocationPermission = AutoDisposeNotifier<bool>;
String _$storagePermissionHash() => r'a7cb18c8b72ddff57b0953536b69bc2c2f0f003f';

/// See also [StoragePermission].
@ProviderFor(StoragePermission)
final storagePermissionProvider =
    AutoDisposeAsyncNotifierProvider<StoragePermission, bool>.internal(
  StoragePermission.new,
  name: r'storagePermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$storagePermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$StoragePermission = AutoDisposeAsyncNotifier<bool>;
String _$cameraPermissionHash() => r'94fc1880b9c094e94aaa3d8718b994d62aed9de4';

/// See also [CameraPermission].
@ProviderFor(CameraPermission)
final cameraPermissionProvider =
    AutoDisposeAsyncNotifierProvider<CameraPermission, bool>.internal(
  CameraPermission.new,
  name: r'cameraPermissionProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cameraPermissionHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CameraPermission = AutoDisposeAsyncNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isLoggedInHash() => r'273aaeed63a5c78b2a98f8d915075f31f6fb2ca3';

/// See also [isLoggedIn].
@ProviderFor(isLoggedIn)
final isLoggedInProvider = AutoDisposeProvider<bool>.internal(
  isLoggedIn,
  name: r'isLoggedInProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoggedInHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsLoggedInRef = AutoDisposeProviderRef<bool>;
String _$userIdHash() => r'1bee323cddbc02a2aea282dfa3fb680867dcc37e';

/// See also [userId].
@ProviderFor(userId)
final userIdProvider = AutoDisposeProvider<UserId>.internal(
  userId,
  name: r'userIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserIdRef = AutoDisposeProviderRef<UserId>;
String _$isOwnerHash() => r'f91677b2c489c301cd87b3dd31fa5dbb5d7858b1';

/// See also [isOwner].
@ProviderFor(isOwner)
final isOwnerProvider = AutoDisposeProvider<bool>.internal(
  isOwner,
  name: r'isOwnerProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isOwnerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsOwnerRef = AutoDisposeProviderRef<bool>;
String _$isLoadingHash() => r'19faabf3075060706ab95de72bda4642d073a224';

/// See also [isLoading].
@ProviderFor(isLoading)
final isLoadingProvider = AutoDisposeProvider<bool>.internal(
  isLoading,
  name: r'isLoadingProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$isLoadingHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsLoadingRef = AutoDisposeProviderRef<bool>;
String _$userImageHash() => r'c86770d203041df3d87ba1960ae8e078dd44f255';

/// See also [userImage].
@ProviderFor(userImage)
final userImageProvider = AutoDisposeProvider<Widget>.internal(
  userImage,
  name: r'userImageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userImageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserImageRef = AutoDisposeProviderRef<Widget>;
String _$fetchFavoriteTracksHash() =>
    r'9f7758be0e057b530bcd8e4aadf0f7f8539b903f';

/// See also [fetchFavoriteTracks].
@ProviderFor(fetchFavoriteTracks)
final fetchFavoriteTracksProvider =
    AutoDisposeFutureProvider<List<TrackId>>.internal(
  fetchFavoriteTracks,
  name: r'fetchFavoriteTracksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchFavoriteTracksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchFavoriteTracksRef = AutoDisposeFutureProviderRef<List<TrackId>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

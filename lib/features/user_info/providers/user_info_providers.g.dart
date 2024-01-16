// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isLoggedInHash() => r'd3d07253f79d66db7d56727fbeadbb347a6dc13f';

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
String _$isOwnerHash() => r'a428beb61180721d62123c5a5627af50daf8200a';

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
String _$userImageHash() => r'd109a1ab4421111ea4d72a1afa810674a886cdb6';

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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$isLoggedInHash() => r'8ca0f8089d0722001c62f68a46814a709e6fd8d3';

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
String _$userIdHash() => r'493d5594980a0279e8dd9b5c873b5d35cbee98e2';

/// See also [userId].
@ProviderFor(userId)
final userIdProvider = AutoDisposeProvider<UserId?>.internal(
  userId,
  name: r'userIdProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserIdRef = AutoDisposeProviderRef<UserId?>;
String _$isLoadingHash() => r'4599ed905c85fb7bc89b102db96e88277c2a9c9b';

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
String _$userImageHash() => r'c497dd4e0d169c0f21512cfca2bb34256626f3e7';

/// See also [userImage].
@ProviderFor(userImage)
final userImageProvider = AutoDisposeFutureProvider<Widget>.internal(
  userImage,
  name: r'userImageProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$userImageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef UserImageRef = AutoDisposeFutureProviderRef<Widget>;
String _$fetchUserInfoHash() => r'14cf5378e7167f8a25f30fb24000a0469516493a';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [fetchUserInfo].
@ProviderFor(fetchUserInfo)
const fetchUserInfoProvider = FetchUserInfoFamily();

/// See also [fetchUserInfo].
class FetchUserInfoFamily extends Family<AsyncValue<UserInfo>> {
  /// See also [fetchUserInfo].
  const FetchUserInfoFamily();

  /// See also [fetchUserInfo].
  FetchUserInfoProvider call(
    String userId,
  ) {
    return FetchUserInfoProvider(
      userId,
    );
  }

  @override
  FetchUserInfoProvider getProviderOverride(
    covariant FetchUserInfoProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'fetchUserInfoProvider';
}

/// See also [fetchUserInfo].
class FetchUserInfoProvider extends AutoDisposeStreamProvider<UserInfo> {
  /// See also [fetchUserInfo].
  FetchUserInfoProvider(
    String userId,
  ) : this._internal(
          (ref) => fetchUserInfo(
            ref as FetchUserInfoRef,
            userId,
          ),
          from: fetchUserInfoProvider,
          name: r'fetchUserInfoProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchUserInfoHash,
          dependencies: FetchUserInfoFamily._dependencies,
          allTransitiveDependencies:
              FetchUserInfoFamily._allTransitiveDependencies,
          userId: userId,
        );

  FetchUserInfoProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    Stream<UserInfo> Function(FetchUserInfoRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchUserInfoProvider._internal(
        (ref) => create(ref as FetchUserInfoRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<UserInfo> createElement() {
    return _FetchUserInfoProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchUserInfoProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchUserInfoRef on AutoDisposeStreamProviderRef<UserInfo> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _FetchUserInfoProviderElement
    extends AutoDisposeStreamProviderElement<UserInfo> with FetchUserInfoRef {
  _FetchUserInfoProviderElement(super.provider);

  @override
  String get userId => (origin as FetchUserInfoProvider).userId;
}

String _$authStateNotifierHash() => r'62155fa5c18699397c79768434b855adefd51bbd';

/// See also [AuthStateNotifier].
@ProviderFor(AuthStateNotifier)
final authStateNotifierProvider =
    AutoDisposeNotifierProvider<AuthStateNotifier, AuthState>.internal(
  AuthStateNotifier.new,
  name: r'authStateNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$authStateNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$AuthStateNotifier = AutoDisposeNotifier<AuthState>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

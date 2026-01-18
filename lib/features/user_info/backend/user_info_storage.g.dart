// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_storage.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides a [UserInfoStorage] instance with dependencies injected.

@ProviderFor(userInfoStorage)
final userInfoStorageProvider = UserInfoStorageProvider._();

/// Provides a [UserInfoStorage] instance with dependencies injected.

final class UserInfoStorageProvider
    extends
        $FunctionalProvider<UserInfoStorage, UserInfoStorage, UserInfoStorage>
    with $Provider<UserInfoStorage> {
  /// Provides a [UserInfoStorage] instance with dependencies injected.
  UserInfoStorageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userInfoStorageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userInfoStorageHash();

  @$internal
  @override
  $ProviderElement<UserInfoStorage> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserInfoStorage create(Ref ref) {
    return userInfoStorage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserInfoStorage value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserInfoStorage>(value),
    );
  }
}

String _$userInfoStorageHash() => r'079ae10e51790dc82f35c851b574b867e55690f7';

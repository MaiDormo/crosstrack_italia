// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(isLoggedIn)
final isLoggedInProvider = IsLoggedInProvider._();

final class IsLoggedInProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsLoggedInProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isLoggedInProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isLoggedInHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isLoggedIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isLoggedInHash() => r'399a474f5905a8c6f124d9428e3a818e5d609142';

@ProviderFor(userId)
final userIdProvider = UserIdProvider._();

final class UserIdProvider extends $FunctionalProvider<UserId, UserId, UserId>
    with $Provider<UserId> {
  UserIdProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userIdProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userIdHash();

  @$internal
  @override
  $ProviderElement<UserId> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UserId create(Ref ref) {
    return userId(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserId value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserId>(value),
    );
  }
}

String _$userIdHash() => r'935d599d583faf5de672ba645acde94f51734788';

@ProviderFor(isOwner)
final isOwnerProvider = IsOwnerProvider._();

final class IsOwnerProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  IsOwnerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isOwnerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isOwnerHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isOwner(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isOwnerHash() => r'43e049a7967d58f62fb9423d3734758628432cda';

@ProviderFor(userImage)
final userImageProvider = UserImageProvider._();

final class UserImageProvider
    extends $FunctionalProvider<Widget, Widget, Widget>
    with $Provider<Widget> {
  UserImageProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userImageProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userImageHash();

  @$internal
  @override
  $ProviderElement<Widget> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Widget create(Ref ref) {
    return userImage(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Widget value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Widget>(value),
    );
  }
}

String _$userImageHash() => r'7954fbc3d4a20dfa72c50dd8a68542c8cdfefab3';

@ProviderFor(fetchFavoriteTracks)
final fetchFavoriteTracksProvider = FetchFavoriteTracksProvider._();

final class FetchFavoriteTracksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<TrackId>>,
          List<TrackId>,
          FutureOr<List<TrackId>>
        >
    with $FutureModifier<List<TrackId>>, $FutureProvider<List<TrackId>> {
  FetchFavoriteTracksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchFavoriteTracksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchFavoriteTracksHash();

  @$internal
  @override
  $FutureProviderElement<List<TrackId>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<TrackId>> create(Ref ref) {
    return fetchFavoriteTracks(ref);
  }
}

String _$fetchFavoriteTracksHash() =>
    r'1d86bec80fe512a5d4d969ff2e623a3e5a780fa1';

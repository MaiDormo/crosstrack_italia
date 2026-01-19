// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_location_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Tracks whether GPS is currently having errors (especially on web)

@ProviderFor(GpsError)
final gpsErrorProvider = GpsErrorProvider._();

/// Tracks whether GPS is currently having errors (especially on web)
final class GpsErrorProvider extends $NotifierProvider<GpsError, String?> {
  /// Tracks whether GPS is currently having errors (especially on web)
  GpsErrorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'gpsErrorProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$gpsErrorHash();

  @$internal
  @override
  GpsError create() => GpsError();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$gpsErrorHash() => r'3ce90406c8499fc13402196ce138577c0ce2d28e';

/// Tracks whether GPS is currently having errors (especially on web)

abstract class _$GpsError extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String?, String?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String?, String?>,
              String?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(getLocationPlaceString)
final getLocationPlaceStringProvider = GetLocationPlaceStringProvider._();

final class GetLocationPlaceStringProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  GetLocationPlaceStringProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getLocationPlaceStringProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getLocationPlaceStringHash();

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    return getLocationPlaceString(ref);
  }
}

String _$getLocationPlaceStringHash() =>
    r'0ead10ce5fb83c116fb829f1ac85d8e37842567a';

@ProviderFor(getPosition)
final getPositionProvider = GetPositionProvider._();

final class GetPositionProvider
    extends
        $FunctionalProvider<
          AsyncValue<geo.Position?>,
          geo.Position?,
          FutureOr<geo.Position?>
        >
    with $FutureModifier<geo.Position?>, $FutureProvider<geo.Position?> {
  GetPositionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getPositionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getPositionHash();

  @$internal
  @override
  $FutureProviderElement<geo.Position?> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<geo.Position?> create(Ref ref) {
    return getPosition(ref);
  }
}

String _$getPositionHash() => r'b8b4db380e358668cc59da9ee82f4586b1e5d61b';

@ProviderFor(ShowCurrentLocation)
final showCurrentLocationProvider = ShowCurrentLocationProvider._();

final class ShowCurrentLocationProvider
    extends $NotifierProvider<ShowCurrentLocation, bool> {
  ShowCurrentLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'showCurrentLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$showCurrentLocationHash();

  @$internal
  @override
  ShowCurrentLocation create() => ShowCurrentLocation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$showCurrentLocationHash() =>
    r'55be9755ecab2a7bbf0bdb32305ada517759f536';

abstract class _$ShowCurrentLocation extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(CenterUserLocation)
final centerUserLocationProvider = CenterUserLocationProvider._();

final class CenterUserLocationProvider
    extends $NotifierProvider<CenterUserLocation, AlignOnUpdate> {
  CenterUserLocationProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'centerUserLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$centerUserLocationHash();

  @$internal
  @override
  CenterUserLocation create() => CenterUserLocation();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AlignOnUpdate value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AlignOnUpdate>(value),
    );
  }
}

String _$centerUserLocationHash() =>
    r'e027a66edf9c79ff13e6b8ef1ac68ac2d6191db5';

abstract class _$CenterUserLocation extends $Notifier<AlignOnUpdate> {
  AlignOnUpdate build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AlignOnUpdate, AlignOnUpdate>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AlignOnUpdate, AlignOnUpdate>,
              AlignOnUpdate,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(UserLocationNotifier)
final userLocationProvider = UserLocationNotifierProvider._();

final class UserLocationNotifierProvider
    extends $NotifierProvider<UserLocationNotifier, void> {
  UserLocationNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userLocationProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userLocationNotifierHash();

  @$internal
  @override
  UserLocationNotifier create() => UserLocationNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$userLocationNotifierHash() =>
    r'9179141198276f792140b734b9833c82c76d16e2';

abstract class _$UserLocationNotifier extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

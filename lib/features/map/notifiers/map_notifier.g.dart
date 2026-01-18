// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(MapNotifier)
final mapProvider = MapNotifierProvider._();

final class MapNotifierProvider extends $NotifierProvider<MapNotifier, bool> {
  MapNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mapProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mapNotifierHash();

  @$internal
  @override
  MapNotifier create() => MapNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$mapNotifierHash() => r'c2ff884c912f3006df509052957bede3a0296029';

abstract class _$MapNotifier extends $Notifier<bool> {
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

@ProviderFor(vsyncContainer)
final vsyncContainerProvider = VsyncContainerProvider._();

final class VsyncContainerProvider
    extends $FunctionalProvider<VsyncContainer, VsyncContainer, VsyncContainer>
    with $Provider<VsyncContainer> {
  VsyncContainerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vsyncContainerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vsyncContainerHash();

  @$internal
  @override
  $ProviderElement<VsyncContainer> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  VsyncContainer create(Ref ref) {
    return vsyncContainer(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(VsyncContainer value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<VsyncContainer>(value),
    );
  }
}

String _$vsyncContainerHash() => r'688009073f9854104115527d9adb8a1d9636acab';

@ProviderFor(vsync)
final vsyncProvider = VsyncProvider._();

final class VsyncProvider
    extends $FunctionalProvider<TickerProvider, TickerProvider, TickerProvider>
    with $Provider<TickerProvider> {
  VsyncProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'vsyncProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$vsyncHash();

  @$internal
  @override
  $ProviderElement<TickerProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TickerProvider create(Ref ref) {
    return vsync(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TickerProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TickerProvider>(value),
    );
  }
}

String _$vsyncHash() => r'd611bb42860c5fc5a05bf73cbf549ce94fe3b936';

@ProviderFor(animatedMapController)
final animatedMapControllerProvider = AnimatedMapControllerProvider._();

final class AnimatedMapControllerProvider
    extends
        $FunctionalProvider<
          AnimatedMapController,
          AnimatedMapController,
          AnimatedMapController
        >
    with $Provider<AnimatedMapController> {
  AnimatedMapControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'animatedMapControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$animatedMapControllerHash();

  @$internal
  @override
  $ProviderElement<AnimatedMapController> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  AnimatedMapController create(Ref ref) {
    return animatedMapController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AnimatedMapController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AnimatedMapController>(value),
    );
  }
}

String _$animatedMapControllerHash() =>
    r'59ec4edf25735141b68931922c1133c228821fa8';

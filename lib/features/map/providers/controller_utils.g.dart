// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'controller_utils.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(panelController)
final panelControllerProvider = PanelControllerProvider._();

final class PanelControllerProvider
    extends
        $FunctionalProvider<PanelController, PanelController, PanelController>
    with $Provider<PanelController> {
  PanelControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'panelControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$panelControllerHash();

  @$internal
  @override
  $ProviderElement<PanelController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PanelController create(Ref ref) {
    return panelController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PanelController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PanelController>(value),
    );
  }
}

String _$panelControllerHash() => r'5c6dcee38e8b07d566646b9c07f5f7043c1e2d7b';

@ProviderFor(popupController)
final popupControllerProvider = PopupControllerProvider._();

final class PopupControllerProvider
    extends
        $FunctionalProvider<PopupController, PopupController, PopupController>
    with $Provider<PopupController> {
  PopupControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'popupControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$popupControllerHash();

  @$internal
  @override
  $ProviderElement<PopupController> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  PopupController create(Ref ref) {
    return popupController(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(PopupController value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<PopupController>(value),
    );
  }
}

String _$popupControllerHash() => r'f3b48a2bcead4b8f0a4a2a5f076b64534c6eb8f6';

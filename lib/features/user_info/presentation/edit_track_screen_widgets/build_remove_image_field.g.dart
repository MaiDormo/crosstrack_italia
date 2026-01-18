// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'build_remove_image_field.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(undoImageDelete)
final undoImageDeleteProvider = UndoImageDeleteProvider._();

final class UndoImageDeleteProvider
    extends
        $FunctionalProvider<
          Map<Widget, String>,
          Map<Widget, String>,
          Map<Widget, String>
        >
    with $Provider<Map<Widget, String>> {
  UndoImageDeleteProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'undoImageDeleteProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$undoImageDeleteHash();

  @$internal
  @override
  $ProviderElement<Map<Widget, String>> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  Map<Widget, String> create(Ref ref) {
    return undoImageDelete(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<Widget, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<Widget, String>>(value),
    );
  }
}

String _$undoImageDeleteHash() => r'6afdf3bd46e7f9fba43d534f7362f7452572268d';

@ProviderFor(ImagesPathToBeDeleted)
final imagesPathToBeDeletedProvider = ImagesPathToBeDeletedProvider._();

final class ImagesPathToBeDeletedProvider
    extends $NotifierProvider<ImagesPathToBeDeleted, Map<Widget, String>> {
  ImagesPathToBeDeletedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'imagesPathToBeDeletedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$imagesPathToBeDeletedHash();

  @$internal
  @override
  ImagesPathToBeDeleted create() => ImagesPathToBeDeleted();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Map<Widget, String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Map<Widget, String>>(value),
    );
  }
}

String _$imagesPathToBeDeletedHash() =>
    r'228a42da19f4661a74209fc7bf9216e481843785';

abstract class _$ImagesPathToBeDeleted extends $Notifier<Map<Widget, String>> {
  Map<Widget, String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Map<Widget, String>, Map<Widget, String>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Map<Widget, String>, Map<Widget, String>>,
              Map<Widget, String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

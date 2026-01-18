// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fetchAllTracks)
final fetchAllTracksProvider = FetchAllTracksProvider._();

final class FetchAllTracksProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Track>>,
          Iterable<Track>,
          Stream<Iterable<Track>>
        >
    with $FutureModifier<Iterable<Track>>, $StreamProvider<Iterable<Track>> {
  FetchAllTracksProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fetchAllTracksProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fetchAllTracksHash();

  @$internal
  @override
  $StreamProviderElement<Iterable<Track>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Iterable<Track>> create(Ref ref) {
    return fetchAllTracks(ref);
  }
}

String _$fetchAllTracksHash() => r'ba2958852b71a6fa452cda2a63a48cd7b1f41806';

@ProviderFor(fetchTracksByRegion)
final fetchTracksByRegionProvider = FetchTracksByRegionFamily._();

final class FetchTracksByRegionProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Track>>,
          Iterable<Track>,
          Stream<Iterable<Track>>
        >
    with $FutureModifier<Iterable<Track>>, $StreamProvider<Iterable<Track>> {
  FetchTracksByRegionProvider._({
    required FetchTracksByRegionFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'fetchTracksByRegionProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchTracksByRegionHash();

  @override
  String toString() {
    return r'fetchTracksByRegionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Iterable<Track>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Iterable<Track>> create(Ref ref) {
    final argument = this.argument as String;
    return fetchTracksByRegion(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchTracksByRegionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchTracksByRegionHash() =>
    r'80e4053801bdaecfad61d0a45d4f5774670a3ff7';

final class FetchTracksByRegionFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Iterable<Track>>, String> {
  FetchTracksByRegionFamily._()
    : super(
        retry: null,
        name: r'fetchTracksByRegionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchTracksByRegionProvider call(String region) =>
      FetchTracksByRegionProvider._(argument: region, from: this);

  @override
  String toString() => r'fetchTracksByRegionProvider';
}

@ProviderFor(fetchSelectedTracksThumbnail)
final fetchSelectedTracksThumbnailProvider =
    FetchSelectedTracksThumbnailFamily._();

final class FetchSelectedTracksThumbnailProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<Widget>>,
          List<Widget>,
          FutureOr<List<Widget>>
        >
    with $FutureModifier<List<Widget>>, $FutureProvider<List<Widget>> {
  FetchSelectedTracksThumbnailProvider._({
    required FetchSelectedTracksThumbnailFamily super.from,
    required List<Track> super.argument,
  }) : super(
         retry: null,
         name: r'fetchSelectedTracksThumbnailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchSelectedTracksThumbnailHash();

  @override
  String toString() {
    return r'fetchSelectedTracksThumbnailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<Widget>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<Widget>> create(Ref ref) {
    final argument = this.argument as List<Track>;
    return fetchSelectedTracksThumbnail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchSelectedTracksThumbnailProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchSelectedTracksThumbnailHash() =>
    r'165df0a73373364198bbcb859f0962991b7f96be';

final class FetchSelectedTracksThumbnailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<Widget>>, List<Track>> {
  FetchSelectedTracksThumbnailFamily._()
    : super(
        retry: null,
        name: r'fetchSelectedTracksThumbnailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchSelectedTracksThumbnailProvider call(List<Track> tracks) =>
      FetchSelectedTracksThumbnailProvider._(argument: tracks, from: this);

  @override
  String toString() => r'fetchSelectedTracksThumbnailProvider';
}

@ProviderFor(trackThumbnail)
final trackThumbnailProvider = TrackThumbnailFamily._();

final class TrackThumbnailProvider
    extends $FunctionalProvider<AsyncValue<Widget>, Widget, FutureOr<Widget>>
    with $FutureModifier<Widget>, $FutureProvider<Widget> {
  TrackThumbnailProvider._({
    required TrackThumbnailFamily super.from,
    required Track super.argument,
  }) : super(
         retry: null,
         name: r'trackThumbnailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trackThumbnailHash();

  @override
  String toString() {
    return r'trackThumbnailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Widget> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Widget> create(Ref ref) {
    final argument = this.argument as Track;
    return trackThumbnail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackThumbnailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trackThumbnailHash() => r'573ae19486cfef8dffffc885a4b4d9912e524334';

final class TrackThumbnailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Widget>, Track> {
  TrackThumbnailFamily._()
    : super(
        retry: null,
        name: r'trackThumbnailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  TrackThumbnailProvider call(Track track) =>
      TrackThumbnailProvider._(argument: track, from: this);

  @override
  String toString() => r'trackThumbnailProvider';
}

@ProviderFor(allTrackImages)
final allTrackImagesProvider = AllTrackImagesProvider._();

final class AllTrackImagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Widget>>,
          Iterable<Widget>,
          FutureOr<Iterable<Widget>>
        >
    with $FutureModifier<Iterable<Widget>>, $FutureProvider<Iterable<Widget>> {
  AllTrackImagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'allTrackImagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$allTrackImagesHash();

  @$internal
  @override
  $FutureProviderElement<Iterable<Widget>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Iterable<Widget>> create(Ref ref) {
    return allTrackImages(ref);
  }
}

String _$allTrackImagesHash() => r'a3f4abbf7c482ac2b8bafba30abb940eecc4515d';

@ProviderFor(allTrackImagesByTrack)
final allTrackImagesByTrackProvider = AllTrackImagesByTrackFamily._();

final class AllTrackImagesByTrackProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Widget>>,
          Iterable<Widget>,
          FutureOr<Iterable<Widget>>
        >
    with $FutureModifier<Iterable<Widget>>, $FutureProvider<Iterable<Widget>> {
  AllTrackImagesByTrackProvider._({
    required AllTrackImagesByTrackFamily super.from,
    required (Track, bool) super.argument,
  }) : super(
         retry: null,
         name: r'allTrackImagesByTrackProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$allTrackImagesByTrackHash();

  @override
  String toString() {
    return r'allTrackImagesByTrackProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Iterable<Widget>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Iterable<Widget>> create(Ref ref) {
    final argument = this.argument as (Track, bool);
    return allTrackImagesByTrack(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is AllTrackImagesByTrackProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$allTrackImagesByTrackHash() =>
    r'7ab870ff43e6974fe8ec98ccf640d8fd5fcbef5b';

final class AllTrackImagesByTrackFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Iterable<Widget>>, (Track, bool)> {
  AllTrackImagesByTrackFamily._()
    : super(
        retry: null,
        name: r'allTrackImagesByTrackProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AllTrackImagesByTrackProvider call(Track track, bool highQuality) =>
      AllTrackImagesByTrackProvider._(
        argument: (track, highQuality),
        from: this,
      );

  @override
  String toString() => r'allTrackImagesByTrackProvider';
}

@ProviderFor(allTrackImagesWithPaths)
final allTrackImagesWithPathsProvider = AllTrackImagesWithPathsFamily._();

final class AllTrackImagesWithPathsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Map<Widget, String>>,
          Map<Widget, String>,
          FutureOr<Map<Widget, String>>
        >
    with
        $FutureModifier<Map<Widget, String>>,
        $FutureProvider<Map<Widget, String>> {
  AllTrackImagesWithPathsProvider._({
    required AllTrackImagesWithPathsFamily super.from,
    required Track super.argument,
  }) : super(
         retry: null,
         name: r'allTrackImagesWithPathsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$allTrackImagesWithPathsHash();

  @override
  String toString() {
    return r'allTrackImagesWithPathsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Map<Widget, String>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Map<Widget, String>> create(Ref ref) {
    final argument = this.argument as Track;
    return allTrackImagesWithPaths(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is AllTrackImagesWithPathsProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$allTrackImagesWithPathsHash() =>
    r'780c54c1eeea899c6e93399a85b29f172c8d8257';

final class AllTrackImagesWithPathsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Map<Widget, String>>, Track> {
  AllTrackImagesWithPathsFamily._()
    : super(
        retry: null,
        name: r'allTrackImagesWithPathsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  AllTrackImagesWithPathsProvider call(Track track) =>
      AllTrackImagesWithPathsProvider._(argument: track, from: this);

  @override
  String toString() => r'allTrackImagesWithPathsProvider';
}

@ProviderFor(fetchCommentsByTrackId)
final fetchCommentsByTrackIdProvider = FetchCommentsByTrackIdFamily._();

final class FetchCommentsByTrackIdProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Comment>>,
          Iterable<Comment>,
          Stream<Iterable<Comment>>
        >
    with
        $FutureModifier<Iterable<Comment>>,
        $StreamProvider<Iterable<Comment>> {
  FetchCommentsByTrackIdProvider._({
    required FetchCommentsByTrackIdFamily super.from,
    required TrackId super.argument,
  }) : super(
         retry: null,
         name: r'fetchCommentsByTrackIdProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchCommentsByTrackIdHash();

  @override
  String toString() {
    return r'fetchCommentsByTrackIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $StreamProviderElement<Iterable<Comment>> $createElement(
    $ProviderPointer pointer,
  ) => $StreamProviderElement(pointer);

  @override
  Stream<Iterable<Comment>> create(Ref ref) {
    final argument = this.argument as TrackId;
    return fetchCommentsByTrackId(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCommentsByTrackIdProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchCommentsByTrackIdHash() =>
    r'64b3c08d62d76b4ee3d07a4ac3097e747c08b165';

final class FetchCommentsByTrackIdFamily extends $Family
    with $FunctionalFamilyOverride<Stream<Iterable<Comment>>, TrackId> {
  FetchCommentsByTrackIdFamily._()
    : super(
        retry: null,
        name: r'fetchCommentsByTrackIdProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchCommentsByTrackIdProvider call(TrackId id) =>
      FetchCommentsByTrackIdProvider._(argument: id, from: this);

  @override
  String toString() => r'fetchCommentsByTrackIdProvider';
}

@ProviderFor(openGoogleMap)
final openGoogleMapProvider = OpenGoogleMapFamily._();

final class OpenGoogleMapProvider
    extends $FunctionalProvider<AsyncValue<bool>, bool, FutureOr<bool>>
    with $FutureModifier<bool>, $FutureProvider<bool> {
  OpenGoogleMapProvider._({
    required OpenGoogleMapFamily super.from,
    required Track super.argument,
  }) : super(
         retry: null,
         name: r'openGoogleMapProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$openGoogleMapHash();

  @override
  String toString() {
    return r'openGoogleMapProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<bool> create(Ref ref) {
    final argument = this.argument as Track;
    return openGoogleMap(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenGoogleMapProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$openGoogleMapHash() => r'17b1d1661163250e1c5ca7cb1e64d2db733b2f88';

final class OpenGoogleMapFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<bool>, Track> {
  OpenGoogleMapFamily._()
    : super(
        retry: null,
        name: r'openGoogleMapProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  OpenGoogleMapProvider call(Track track) =>
      OpenGoogleMapProvider._(argument: track, from: this);

  @override
  String toString() => r'openGoogleMapProvider';
}

@ProviderFor(fetchTracksByIds)
final fetchTracksByIdsProvider = FetchTracksByIdsFamily._();

final class FetchTracksByIdsProvider
    extends
        $FunctionalProvider<
          AsyncValue<Iterable<Track>>,
          Iterable<Track>,
          FutureOr<Iterable<Track>>
        >
    with $FutureModifier<Iterable<Track>>, $FutureProvider<Iterable<Track>> {
  FetchTracksByIdsProvider._({
    required FetchTracksByIdsFamily super.from,
    required (List<TrackId>, BuildContext) super.argument,
  }) : super(
         retry: null,
         name: r'fetchTracksByIdsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$fetchTracksByIdsHash();

  @override
  String toString() {
    return r'fetchTracksByIdsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<Iterable<Track>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Iterable<Track>> create(Ref ref) {
    final argument = this.argument as (List<TrackId>, BuildContext);
    return fetchTracksByIds(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchTracksByIdsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$fetchTracksByIdsHash() => r'960b072f0d995c97cebae1017935ae6a13db39f3';

final class FetchTracksByIdsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<Iterable<Track>>,
          (List<TrackId>, BuildContext)
        > {
  FetchTracksByIdsFamily._()
    : super(
        retry: null,
        name: r'fetchTracksByIdsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  FetchTracksByIdsProvider call(
    List<TrackId> favoriteTracks,
    BuildContext context,
  ) => FetchTracksByIdsProvider._(
    argument: (favoriteTracks, context),
    from: this,
  );

  @override
  String toString() => r'fetchTracksByIdsProvider';
}

@ProviderFor(ToggleIconsServicesView)
final toggleIconsServicesViewProvider = ToggleIconsServicesViewProvider._();

final class ToggleIconsServicesViewProvider
    extends $NotifierProvider<ToggleIconsServicesView, bool> {
  ToggleIconsServicesViewProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'toggleIconsServicesViewProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$toggleIconsServicesViewHash();

  @$internal
  @override
  ToggleIconsServicesView create() => ToggleIconsServicesView();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$toggleIconsServicesViewHash() =>
    r'dbf9ba248439d91ddfcc61e02ea37ced3dcaa509';

abstract class _$ToggleIconsServicesView extends $Notifier<bool> {
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

@ProviderFor(TrackSelected)
final trackSelectedProvider = TrackSelectedProvider._();

final class TrackSelectedProvider
    extends $NotifierProvider<TrackSelected, Track> {
  TrackSelectedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackSelectedProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackSelectedHash();

  @$internal
  @override
  TrackSelected create() => TrackSelected();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Track value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Track>(value),
    );
  }
}

String _$trackSelectedHash() => r'47399025a25896113791f1c4cc469add9c2f916d';

abstract class _$TrackSelected extends $Notifier<Track> {
  Track build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Track, Track>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Track, Track>,
              Track,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(TrackNotifier)
final trackProvider = TrackNotifierProvider._();

final class TrackNotifierProvider
    extends $NotifierProvider<TrackNotifier, bool> {
  TrackNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackNotifierHash();

  @$internal
  @override
  TrackNotifier create() => TrackNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$trackNotifierHash() => r'a547a23b88f8e7f891077831386f091d39f9c19b';

abstract class _$TrackNotifier extends $Notifier<bool> {
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

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$fetchAllTracksHash() => r'e25ac7f58f05616545bf3c4735803dabc8143df6';

/// See also [fetchAllTracks].
@ProviderFor(fetchAllTracks)
final fetchAllTracksProvider =
    AutoDisposeStreamProvider<Iterable<Track>>.internal(
  fetchAllTracks,
  name: r'fetchAllTracksProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$fetchAllTracksHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef FetchAllTracksRef = AutoDisposeStreamProviderRef<Iterable<Track>>;
String _$fetchTracksByRegionHash() =>
    r'cd04cbc1d2e0665b929403b8274c1b678835f802';

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

/// See also [fetchTracksByRegion].
@ProviderFor(fetchTracksByRegion)
const fetchTracksByRegionProvider = FetchTracksByRegionFamily();

/// See also [fetchTracksByRegion].
class FetchTracksByRegionFamily extends Family<AsyncValue<Iterable<Track>>> {
  /// See also [fetchTracksByRegion].
  const FetchTracksByRegionFamily();

  /// See also [fetchTracksByRegion].
  FetchTracksByRegionProvider call(
    String region,
  ) {
    return FetchTracksByRegionProvider(
      region,
    );
  }

  @override
  FetchTracksByRegionProvider getProviderOverride(
    covariant FetchTracksByRegionProvider provider,
  ) {
    return call(
      provider.region,
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
  String? get name => r'fetchTracksByRegionProvider';
}

/// See also [fetchTracksByRegion].
class FetchTracksByRegionProvider
    extends AutoDisposeStreamProvider<Iterable<Track>> {
  /// See also [fetchTracksByRegion].
  FetchTracksByRegionProvider(
    String region,
  ) : this._internal(
          (ref) => fetchTracksByRegion(
            ref as FetchTracksByRegionRef,
            region,
          ),
          from: fetchTracksByRegionProvider,
          name: r'fetchTracksByRegionProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchTracksByRegionHash,
          dependencies: FetchTracksByRegionFamily._dependencies,
          allTransitiveDependencies:
              FetchTracksByRegionFamily._allTransitiveDependencies,
          region: region,
        );

  FetchTracksByRegionProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.region,
  }) : super.internal();

  final String region;

  @override
  Override overrideWith(
    Stream<Iterable<Track>> Function(FetchTracksByRegionRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchTracksByRegionProvider._internal(
        (ref) => create(ref as FetchTracksByRegionRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        region: region,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Iterable<Track>> createElement() {
    return _FetchTracksByRegionProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchTracksByRegionProvider && other.region == region;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, region.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchTracksByRegionRef on AutoDisposeStreamProviderRef<Iterable<Track>> {
  /// The parameter `region` of this provider.
  String get region;
}

class _FetchTracksByRegionProviderElement
    extends AutoDisposeStreamProviderElement<Iterable<Track>>
    with FetchTracksByRegionRef {
  _FetchTracksByRegionProviderElement(super.provider);

  @override
  String get region => (origin as FetchTracksByRegionProvider).region;
}

String _$fetchSelectedTracksThumbnailHash() =>
    r'4679a4383a07d517a37269cee7bd0028ca1fc096';

/// See also [fetchSelectedTracksThumbnail].
@ProviderFor(fetchSelectedTracksThumbnail)
const fetchSelectedTracksThumbnailProvider =
    FetchSelectedTracksThumbnailFamily();

/// See also [fetchSelectedTracksThumbnail].
class FetchSelectedTracksThumbnailFamily
    extends Family<AsyncValue<List<Image>>> {
  /// See also [fetchSelectedTracksThumbnail].
  const FetchSelectedTracksThumbnailFamily();

  /// See also [fetchSelectedTracksThumbnail].
  FetchSelectedTracksThumbnailProvider call(
    List<Track> tracks,
  ) {
    return FetchSelectedTracksThumbnailProvider(
      tracks,
    );
  }

  @override
  FetchSelectedTracksThumbnailProvider getProviderOverride(
    covariant FetchSelectedTracksThumbnailProvider provider,
  ) {
    return call(
      provider.tracks,
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
  String? get name => r'fetchSelectedTracksThumbnailProvider';
}

/// See also [fetchSelectedTracksThumbnail].
class FetchSelectedTracksThumbnailProvider
    extends AutoDisposeFutureProvider<List<Image>> {
  /// See also [fetchSelectedTracksThumbnail].
  FetchSelectedTracksThumbnailProvider(
    List<Track> tracks,
  ) : this._internal(
          (ref) => fetchSelectedTracksThumbnail(
            ref as FetchSelectedTracksThumbnailRef,
            tracks,
          ),
          from: fetchSelectedTracksThumbnailProvider,
          name: r'fetchSelectedTracksThumbnailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchSelectedTracksThumbnailHash,
          dependencies: FetchSelectedTracksThumbnailFamily._dependencies,
          allTransitiveDependencies:
              FetchSelectedTracksThumbnailFamily._allTransitiveDependencies,
          tracks: tracks,
        );

  FetchSelectedTracksThumbnailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tracks,
  }) : super.internal();

  final List<Track> tracks;

  @override
  Override overrideWith(
    FutureOr<List<Image>> Function(FetchSelectedTracksThumbnailRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchSelectedTracksThumbnailProvider._internal(
        (ref) => create(ref as FetchSelectedTracksThumbnailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tracks: tracks,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<Image>> createElement() {
    return _FetchSelectedTracksThumbnailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchSelectedTracksThumbnailProvider &&
        other.tracks == tracks;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tracks.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchSelectedTracksThumbnailRef
    on AutoDisposeFutureProviderRef<List<Image>> {
  /// The parameter `tracks` of this provider.
  List<Track> get tracks;
}

class _FetchSelectedTracksThumbnailProviderElement
    extends AutoDisposeFutureProviderElement<List<Image>>
    with FetchSelectedTracksThumbnailRef {
  _FetchSelectedTracksThumbnailProviderElement(super.provider);

  @override
  List<Track> get tracks =>
      (origin as FetchSelectedTracksThumbnailProvider).tracks;
}

String _$trackThumbnailHash() => r'b9adc03fcdc280e891219bf2c10e6474f0d9a37a';

/// See also [trackThumbnail].
@ProviderFor(trackThumbnail)
const trackThumbnailProvider = TrackThumbnailFamily();

/// See also [trackThumbnail].
class TrackThumbnailFamily extends Family<AsyncValue<Image>> {
  /// See also [trackThumbnail].
  const TrackThumbnailFamily();

  /// See also [trackThumbnail].
  TrackThumbnailProvider call(
    Track track,
  ) {
    return TrackThumbnailProvider(
      track,
    );
  }

  @override
  TrackThumbnailProvider getProviderOverride(
    covariant TrackThumbnailProvider provider,
  ) {
    return call(
      provider.track,
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
  String? get name => r'trackThumbnailProvider';
}

/// See also [trackThumbnail].
class TrackThumbnailProvider extends AutoDisposeFutureProvider<Image> {
  /// See also [trackThumbnail].
  TrackThumbnailProvider(
    Track track,
  ) : this._internal(
          (ref) => trackThumbnail(
            ref as TrackThumbnailRef,
            track,
          ),
          from: trackThumbnailProvider,
          name: r'trackThumbnailProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$trackThumbnailHash,
          dependencies: TrackThumbnailFamily._dependencies,
          allTransitiveDependencies:
              TrackThumbnailFamily._allTransitiveDependencies,
          track: track,
        );

  TrackThumbnailProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.track,
  }) : super.internal();

  final Track track;

  @override
  Override overrideWith(
    FutureOr<Image> Function(TrackThumbnailRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TrackThumbnailProvider._internal(
        (ref) => create(ref as TrackThumbnailRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        track: track,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Image> createElement() {
    return _TrackThumbnailProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TrackThumbnailProvider && other.track == track;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, track.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TrackThumbnailRef on AutoDisposeFutureProviderRef<Image> {
  /// The parameter `track` of this provider.
  Track get track;
}

class _TrackThumbnailProviderElement
    extends AutoDisposeFutureProviderElement<Image> with TrackThumbnailRef {
  _TrackThumbnailProviderElement(super.provider);

  @override
  Track get track => (origin as TrackThumbnailProvider).track;
}

String _$allTrackImagesHash() => r'3b46fb9fe845b0bebeb48f3b624e6c2ddb53360f';

/// See also [allTrackImages].
@ProviderFor(allTrackImages)
final allTrackImagesProvider =
    AutoDisposeStreamProvider<Iterable<Image>>.internal(
  allTrackImages,
  name: r'allTrackImagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$allTrackImagesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllTrackImagesRef = AutoDisposeStreamProviderRef<Iterable<Image>>;
String _$fetchCommentsByTrackIdHash() =>
    r'caae1c8154d8e4d68921a7948ea616d908716239';

/// See also [fetchCommentsByTrackId].
@ProviderFor(fetchCommentsByTrackId)
const fetchCommentsByTrackIdProvider = FetchCommentsByTrackIdFamily();

/// See also [fetchCommentsByTrackId].
class FetchCommentsByTrackIdFamily
    extends Family<AsyncValue<Iterable<Comment>>> {
  /// See also [fetchCommentsByTrackId].
  const FetchCommentsByTrackIdFamily();

  /// See also [fetchCommentsByTrackId].
  FetchCommentsByTrackIdProvider call(
    String id,
  ) {
    return FetchCommentsByTrackIdProvider(
      id,
    );
  }

  @override
  FetchCommentsByTrackIdProvider getProviderOverride(
    covariant FetchCommentsByTrackIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'fetchCommentsByTrackIdProvider';
}

/// See also [fetchCommentsByTrackId].
class FetchCommentsByTrackIdProvider
    extends AutoDisposeStreamProvider<Iterable<Comment>> {
  /// See also [fetchCommentsByTrackId].
  FetchCommentsByTrackIdProvider(
    String id,
  ) : this._internal(
          (ref) => fetchCommentsByTrackId(
            ref as FetchCommentsByTrackIdRef,
            id,
          ),
          from: fetchCommentsByTrackIdProvider,
          name: r'fetchCommentsByTrackIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchCommentsByTrackIdHash,
          dependencies: FetchCommentsByTrackIdFamily._dependencies,
          allTransitiveDependencies:
              FetchCommentsByTrackIdFamily._allTransitiveDependencies,
          id: id,
        );

  FetchCommentsByTrackIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  Override overrideWith(
    Stream<Iterable<Comment>> Function(FetchCommentsByTrackIdRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FetchCommentsByTrackIdProvider._internal(
        (ref) => create(ref as FetchCommentsByTrackIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeStreamProviderElement<Iterable<Comment>> createElement() {
    return _FetchCommentsByTrackIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FetchCommentsByTrackIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FetchCommentsByTrackIdRef
    on AutoDisposeStreamProviderRef<Iterable<Comment>> {
  /// The parameter `id` of this provider.
  String get id;
}

class _FetchCommentsByTrackIdProviderElement
    extends AutoDisposeStreamProviderElement<Iterable<Comment>>
    with FetchCommentsByTrackIdRef {
  _FetchCommentsByTrackIdProviderElement(super.provider);

  @override
  String get id => (origin as FetchCommentsByTrackIdProvider).id;
}

String _$openGoogleMapHash() => r'19a0ee01b503a7253ff4095b2db84cabb9908836';

/// See also [openGoogleMap].
@ProviderFor(openGoogleMap)
const openGoogleMapProvider = OpenGoogleMapFamily();

/// See also [openGoogleMap].
class OpenGoogleMapFamily extends Family<AsyncValue<bool>> {
  /// See also [openGoogleMap].
  const OpenGoogleMapFamily();

  /// See also [openGoogleMap].
  OpenGoogleMapProvider call(
    Track? track,
  ) {
    return OpenGoogleMapProvider(
      track,
    );
  }

  @override
  OpenGoogleMapProvider getProviderOverride(
    covariant OpenGoogleMapProvider provider,
  ) {
    return call(
      provider.track,
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
  String? get name => r'openGoogleMapProvider';
}

/// See also [openGoogleMap].
class OpenGoogleMapProvider extends AutoDisposeFutureProvider<bool> {
  /// See also [openGoogleMap].
  OpenGoogleMapProvider(
    Track? track,
  ) : this._internal(
          (ref) => openGoogleMap(
            ref as OpenGoogleMapRef,
            track,
          ),
          from: openGoogleMapProvider,
          name: r'openGoogleMapProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$openGoogleMapHash,
          dependencies: OpenGoogleMapFamily._dependencies,
          allTransitiveDependencies:
              OpenGoogleMapFamily._allTransitiveDependencies,
          track: track,
        );

  OpenGoogleMapProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.track,
  }) : super.internal();

  final Track? track;

  @override
  Override overrideWith(
    FutureOr<bool> Function(OpenGoogleMapRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: OpenGoogleMapProvider._internal(
        (ref) => create(ref as OpenGoogleMapRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        track: track,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<bool> createElement() {
    return _OpenGoogleMapProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OpenGoogleMapProvider && other.track == track;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, track.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin OpenGoogleMapRef on AutoDisposeFutureProviderRef<bool> {
  /// The parameter `track` of this provider.
  Track? get track;
}

class _OpenGoogleMapProviderElement
    extends AutoDisposeFutureProviderElement<bool> with OpenGoogleMapRef {
  _OpenGoogleMapProviderElement(super.provider);

  @override
  Track? get track => (origin as OpenGoogleMapProvider).track;
}

String _$toggleIconsServicesViewHash() =>
    r'dbf9ba248439d91ddfcc61e02ea37ced3dcaa509';

/// See also [ToggleIconsServicesView].
@ProviderFor(ToggleIconsServicesView)
final toggleIconsServicesViewProvider =
    AutoDisposeNotifierProvider<ToggleIconsServicesView, bool>.internal(
  ToggleIconsServicesView.new,
  name: r'toggleIconsServicesViewProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$toggleIconsServicesViewHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ToggleIconsServicesView = AutoDisposeNotifier<bool>;
String _$trackSelectedHash() => r'6504919610481210b3fc52781575960807ea423b';

/// See also [TrackSelected].
@ProviderFor(TrackSelected)
final trackSelectedProvider =
    AutoDisposeNotifierProvider<TrackSelected, Track>.internal(
  TrackSelected.new,
  name: r'trackSelectedProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$trackSelectedHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TrackSelected = AutoDisposeNotifier<Track>;
String _$trackNotifierHash() => r'd3de4aa9a61dc7adfb247c23cf7900a9db1794f3';

/// See also [TrackNotifier].
@ProviderFor(TrackNotifier)
final trackNotifierProvider =
    AutoDisposeNotifierProvider<TrackNotifier, bool>.internal(
  TrackNotifier.new,
  name: r'trackNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$trackNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$TrackNotifier = AutoDisposeNotifier<bool>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

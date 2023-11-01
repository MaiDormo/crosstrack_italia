// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_images_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$trackThumbnailHash() => r'a06c85d5d8a9c478bdce87fc4d6ae2226c9f4197';

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

/// See also [trackThumbnail].
@ProviderFor(trackThumbnail)
const trackThumbnailProvider = TrackThumbnailFamily();

/// See also [trackThumbnail].
class TrackThumbnailFamily extends Family<AsyncValue<Image>> {
  /// See also [trackThumbnail].
  const TrackThumbnailFamily();

  /// See also [trackThumbnail].
  TrackThumbnailProvider call(
    TrackInfoModel track,
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
    TrackInfoModel track,
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

  final TrackInfoModel track;

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
  TrackInfoModel get track;
}

class _TrackThumbnailProviderElement
    extends AutoDisposeFutureProviderElement<Image> with TrackThumbnailRef {
  _TrackThumbnailProviderElement(super.provider);

  @override
  TrackInfoModel get track => (origin as TrackThumbnailProvider).track;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

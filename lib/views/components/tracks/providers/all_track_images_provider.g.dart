// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'all_track_images_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allTrackImagesHash() => r'cf4d503f766438eb3b19a3e098085cffc5ec926f';

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

/// See also [allTrackImages].
@ProviderFor(allTrackImages)
const allTrackImagesProvider = AllTrackImagesFamily();

/// See also [allTrackImages].
class AllTrackImagesFamily extends Family<AsyncValue<Iterable<Image>>> {
  /// See also [allTrackImages].
  const AllTrackImagesFamily();

  /// See also [allTrackImages].
  AllTrackImagesProvider call(
    Track? track,
  ) {
    return AllTrackImagesProvider(
      track,
    );
  }

  @override
  AllTrackImagesProvider getProviderOverride(
    covariant AllTrackImagesProvider provider,
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
  String? get name => r'allTrackImagesProvider';
}

/// See also [allTrackImages].
class AllTrackImagesProvider
    extends AutoDisposeStreamProvider<Iterable<Image>> {
  /// See also [allTrackImages].
  AllTrackImagesProvider(
    Track? track,
  ) : this._internal(
          (ref) => allTrackImages(
            ref as AllTrackImagesRef,
            track,
          ),
          from: allTrackImagesProvider,
          name: r'allTrackImagesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$allTrackImagesHash,
          dependencies: AllTrackImagesFamily._dependencies,
          allTransitiveDependencies:
              AllTrackImagesFamily._allTransitiveDependencies,
          track: track,
        );

  AllTrackImagesProvider._internal(
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
    Stream<Iterable<Image>> Function(AllTrackImagesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: AllTrackImagesProvider._internal(
        (ref) => create(ref as AllTrackImagesRef),
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
  AutoDisposeStreamProviderElement<Iterable<Image>> createElement() {
    return _AllTrackImagesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is AllTrackImagesProvider && other.track == track;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, track.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin AllTrackImagesRef on AutoDisposeStreamProviderRef<Iterable<Image>> {
  /// The parameter `track` of this provider.
  Track? get track;
}

class _AllTrackImagesProviderElement
    extends AutoDisposeStreamProviderElement<Iterable<Image>>
    with AllTrackImagesRef {
  _AllTrackImagesProviderElement(super.provider);

  @override
  Track? get track => (origin as AllTrackImagesProvider).track;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

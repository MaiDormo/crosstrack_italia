// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Provides a [TrackRepository] instance with Firestore dependency injected.

@ProviderFor(trackRepository)
final trackRepositoryProvider = TrackRepositoryProvider._();

/// Provides a [TrackRepository] instance with Firestore dependency injected.

final class TrackRepositoryProvider
    extends
        $FunctionalProvider<TrackRepository, TrackRepository, TrackRepository>
    with $Provider<TrackRepository> {
  /// Provides a [TrackRepository] instance with Firestore dependency injected.
  TrackRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'trackRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$trackRepositoryHash();

  @$internal
  @override
  $ProviderElement<TrackRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  TrackRepository create(Ref ref) {
    return trackRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(TrackRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<TrackRepository>(value),
    );
  }
}

String _$trackRepositoryHash() => r'6d6f211ae461c8407c249b7cc8f2d4b924baffe8';

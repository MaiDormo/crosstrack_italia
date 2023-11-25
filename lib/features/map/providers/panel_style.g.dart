// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'panel_style.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$heightFactorHash() => r'94b36a8385d4e26114292f4e4148a6c7adbc0443';

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

/// See also [heightFactor].
@ProviderFor(heightFactor)
const heightFactorProvider = HeightFactorFamily();

/// See also [heightFactor].
class HeightFactorFamily extends Family<double> {
  /// See also [heightFactor].
  const HeightFactorFamily();

  /// See also [heightFactor].
  HeightFactorProvider call(
    BuildContext context,
  ) {
    return HeightFactorProvider(
      context,
    );
  }

  @override
  HeightFactorProvider getProviderOverride(
    covariant HeightFactorProvider provider,
  ) {
    return call(
      provider.context,
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
  String? get name => r'heightFactorProvider';
}

/// See also [heightFactor].
class HeightFactorProvider extends AutoDisposeProvider<double> {
  /// See also [heightFactor].
  HeightFactorProvider(
    BuildContext context,
  ) : this._internal(
          (ref) => heightFactor(
            ref as HeightFactorRef,
            context,
          ),
          from: heightFactorProvider,
          name: r'heightFactorProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$heightFactorHash,
          dependencies: HeightFactorFamily._dependencies,
          allTransitiveDependencies:
              HeightFactorFamily._allTransitiveDependencies,
          context: context,
        );

  HeightFactorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.context,
  }) : super.internal();

  final BuildContext context;

  @override
  Override overrideWith(
    double Function(HeightFactorRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: HeightFactorProvider._internal(
        (ref) => create(ref as HeightFactorRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        context: context,
      ),
    );
  }

  @override
  AutoDisposeProviderElement<double> createElement() {
    return _HeightFactorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is HeightFactorProvider && other.context == context;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, context.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin HeightFactorRef on AutoDisposeProviderRef<double> {
  /// The parameter `context` of this provider.
  BuildContext get context;
}

class _HeightFactorProviderElement extends AutoDisposeProviderElement<double>
    with HeightFactorRef {
  _HeightFactorProviderElement(super.provider);

  @override
  BuildContext get context => (origin as HeightFactorProvider).context;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nav_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NavNotifier)
final navProvider = NavNotifierProvider._();

final class NavNotifierProvider
    extends $NotifierProvider<NavNotifier, NavStates> {
  NavNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'navProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$navNotifierHash();

  @$internal
  @override
  NavNotifier create() => NavNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NavStates value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NavStates>(value),
    );
  }
}

String _$navNotifierHash() => r'16c9df64914625f0d10d2c9722f5e59cdaf98238';

abstract class _$NavNotifier extends $Notifier<NavStates> {
  NavStates build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<NavStates, NavStates>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<NavStates, NavStates>,
              NavStates,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

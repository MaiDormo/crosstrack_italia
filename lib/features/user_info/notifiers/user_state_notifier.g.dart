// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_state_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(UserStateNotifier)
final userStateProvider = UserStateNotifierProvider._();

final class UserStateNotifierProvider
    extends $AsyncNotifierProvider<UserStateNotifier, UserInfoModel> {
  UserStateNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userStateProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userStateNotifierHash();

  @$internal
  @override
  UserStateNotifier create() => UserStateNotifier();
}

String _$userStateNotifierHash() => r'9d0d4acbe486b6b158ecda6366e833224ef7cef8';

abstract class _$UserStateNotifier extends $AsyncNotifier<UserInfoModel> {
  FutureOr<UserInfoModel> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserInfoModel>, UserInfoModel>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserInfoModel>, UserInfoModel>,
              AsyncValue<UserInfoModel>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

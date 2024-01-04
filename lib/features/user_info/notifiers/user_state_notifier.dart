import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/backend/user_info_storage.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/features/user_info/models/user_roles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_notifier.g.dart';

@riverpod
class UserStateNotifier extends _$UserStateNotifier {
  late var _userInfoStorage;
  late AsyncValue<AuthState> _authState;

  @override
  Stream<UserInfoModel> build() async* {
    _userInfoStorage = ref.watch(userInfoStorageProvider);
    _authState = ref.watch(authStateNotifierProvider);
    yield switch (_authState) {
      AsyncData(:final value) => await init(value.user),
      _ => UserInfoModel.empty(),
    };
  }

  Future<UserInfoModel> init(User? user) async {
    if (user == null) {
      return UserInfoModel.empty();
    }

    final _fetchedUser = await fetchUserInfo(user.uid);

    if (_fetchedUser == UserInfoModel.empty()) {
      final _newUser = UserInfoModel.fromUser(user).copyWith(
        role: UserRole.user,
      );
      await saveUserInfo(userInfoModel: _newUser);
      return _newUser;
    } else {
      final _updatedUser = UserInfoModel.fromUser(user).copyWith(
        role: _fetchedUser.role,
        favoriteTracks: _fetchedUser.favoriteTracks,
        ownedTracks: _fetchedUser.ownedTracks,
      );
      await saveUserInfo(userInfoModel: _updatedUser);
      return _updatedUser;
    }
  }

  Future<void> saveUserInfo({
    UserInfoModel? userInfoModel,
  }) async {
    if (userInfoModel == null) {
      return Future.value();
    }

    return await _userInfoStorage.saveUserInfo(
      userInfoModel: userInfoModel,
    );
  }

  Future<List<TrackId>> fetchFavoriteTracks() async {
    final user = switch (state) {
      AsyncData(:final value) => value,
      _ => UserInfoModel.empty(),
    };

    state = AsyncLoading();

    if (user.id == '') {
      return [];
    }

    final fetchedUser = await fetchUserInfo(user.id);

    state = AsyncData(fetchedUser);

    return fetchedUser.favoriteTracks ?? [];
  }

  Future<List<TrackId>> fetchOwnedTracks() async {
    final user = switch (state) {
      AsyncData(:final value) => value,
      _ => UserInfoModel.empty(),
    };

    state = AsyncLoading();

    if (user.id == '') {
      return [];
    }

    final fetchedUser = await fetchUserInfo(user.id);

    state = AsyncData(fetchedUser);

    return fetchedUser.ownedTracks ?? [];
  }

  Future<void> makeOwner(List<TrackId> ownedTracks) async {
    final user = state.value!.copyWith(
      role: UserRole.owner,
      ownedTracks: ownedTracks,
    );
    await saveUserInfo(userInfoModel: user);
    state = AsyncData(user);
  }

  Future<UserInfoModel> fetchUserInfo(UserId userId) async {
    return await _userInfoStorage.fetchUserInfo(userId);
  }

  Future<void> deleteUserInfo() async {
    await _userInfoStorage.deleteUserInfo();

    ///TODO: find a actual fix for  this error
    Future.delayed(const Duration(seconds: 1), () {
      ref.read(authStateNotifierProvider.notifier).logOut();
    });
  }
}

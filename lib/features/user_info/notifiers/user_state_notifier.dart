import 'package:crosstrack_italia/features/auth/backend/auth_repository.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/backend/user_info_storage.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/features/user_info/models/user_roles.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_notifier.g.dart';

@riverpod
class UserStateNotifier extends _$UserStateNotifier {
  late UserInfoStorage _userInfoStorage;
  late AsyncValue<User?> _authStateChanges;

  @override
  Future<UserInfoModel> build() async {
    _userInfoStorage = ref.watch(userInfoStorageProvider);
    _authStateChanges = ref.watch(authStateChangesProvider);
    return switch (_authStateChanges) {
      AsyncData(:final value) => await init(value),
      _ => UserInfoModel.empty(),
    };
  }

  Future<UserInfoModel> init(User? user) async {
    if (user == null) {
      return UserInfoModel.empty();
    }

    final UserInfoModel _fetchedUser = await fetchUserInfo(user.uid);

    if (_fetchedUser == UserInfoModel.empty()) {
      final _newUser = UserInfoModel.fromUser(user).copyWith(
        role: UserRole.user,
      );
      await saveUserInfo(userInfoModel: _newUser);
      return _newUser;
    } else {
      final UserInfoModel _updatedUser = UserInfoModel.fromUser(user).copyWith(
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

    return fetchedUser.favoriteTracks;
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

    return fetchedUser.ownedTracks;
  }

  Future<void> makeOwner(List<TrackId> ownedTracks) async {
    final user = state.value!.copyWith(
      role: UserRole.owner,
      ownedTracks: ownedTracks,
    );
    await saveUserInfo(userInfoModel: user);
    state = AsyncData(user);
  }

  Future<void> makeUser() async {
    final user = state.value!.copyWith(
      role: UserRole.user,
      ownedTracks: [],
    );
    await saveUserInfo(userInfoModel: user);
    state = AsyncData(user);
  }

  Future<UserInfoModel> fetchUserInfo(UserId userId) async {
    return await _userInfoStorage.fetchUserInfo(userId);
  }

  Future<void> deleteUserInfo() async {
    await _userInfoStorage.deleteUserInfo();

    Future.delayed(const Duration(seconds: 1), () {
      ref.read(authRepositoryProvider).logOut();
    });
  }
}

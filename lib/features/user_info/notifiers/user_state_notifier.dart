import '../../auth/backend/auth_repository.dart';
import '../../track/models/typedefs/typedefs.dart';
import '../backend/user_info_storage.dart';
import '../models/typedefs/typedefs.dart';
import '../models/user_info_model.dart';
import '../models/user_roles.dart';
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

    final UserInfoModel fetchedUser = await fetchUserInfo(user.uid);

    if (fetchedUser == UserInfoModel.empty()) {
      final newUser = UserInfoModel.fromUser(user).copyWith(
        role: UserRole.user,
      );
      await saveUserInfo(userInfoModel: newUser);
      return newUser;
    } else {
      final UserInfoModel updatedUser = UserInfoModel.fromUser(user).copyWith(
        role: fetchedUser.role,
        favoriteTracks: fetchedUser.favoriteTracks,
        ownedTracks: fetchedUser.ownedTracks,
      );
      await saveUserInfo(userInfoModel: updatedUser);
      return updatedUser;
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

    state = const AsyncLoading();

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

    state = const AsyncLoading();

    if (user.id == '') {
      return [];
    }

    final fetchedUser = await fetchUserInfo(user.id);

    state = AsyncData(fetchedUser);

    return fetchedUser.ownedTracks;
  }

  Future<void> makeOwner(List<TrackId> ownedTracks) async {
    final currentUser = state.value;
    if (currentUser == null) {
      return;
    }
    final user = currentUser.copyWith(
      role: UserRole.owner,
      ownedTracks: ownedTracks,
    );
    await saveUserInfo(userInfoModel: user);
    // Check if still mounted before updating state
    if (!ref.mounted) return;
    state = AsyncData(user);
  }

  Future<void> makeUser() async {
    final currentUser = state.value;
    if (currentUser == null) {
      return;
    }
    final user = currentUser.copyWith(
      role: UserRole.user,
      ownedTracks: [],
    );
    await saveUserInfo(userInfoModel: user);
    // Check if still mounted before updating state
    if (!ref.mounted) return;
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

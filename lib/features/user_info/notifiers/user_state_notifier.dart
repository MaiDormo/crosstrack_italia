import 'package:crosstrack_italia/features/auth/models/auth_state.dart';
import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/backend/user_info_storage.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_state_notifier.g.dart';

@riverpod
class UserStateNotifier extends _$UserStateNotifier {
  late var _userInfoStorage;
  late AsyncValue<AuthState> _authState;

  @override
  Stream<UserInfoModel> build() async* {
    _userInfoStorage = ref.watch(userInfoStorageProvider.notifier);
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
      final _newUser = UserInfoModel.fromUser(user);
      await saveUserInfo(userInfoModel: _newUser);
      return _newUser;
    }

    return _fetchedUser;
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
      isOwner: true,
      ownedTracks: ownedTracks,
    );
    await saveUserInfo(userInfoModel: user);
    state = AsyncData(user);
  }

  Future<UserInfoModel> fetchUserInfo(UserId userId) async {
    final snapshot = await ref
        .read(firestoreProvider)
        .collection(FirebaseCollectionName.users)
        .where(FirebaseFieldName.id, isEqualTo: userId)
        .limit(1)
        .get();

    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final userInfo = UserInfoModel.fromJson(json);
      return userInfo;
    } else {
      return UserInfoModel.empty();
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_storage.g.dart';

@riverpod
class UserInfoStorage extends _$UserInfoStorage {
  late final FirebaseFirestore _firestore;

  @override
  bool build() {
    _firestore = ref.watch(firestoreProvider);
    return false;
  }

  Future<bool> saveUserInfo({
    required UserId id,
    required String displayName,
    required String? email,
    required String? profileImageUrl,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await _firestore
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.id,
            isEqualTo: id,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have this user's profile, save the new data instead
        await userInfo.docs.first.reference.update({
          FirebaseFieldName.displayName: displayName,
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.profileImageUrl: profileImageUrl ?? '',
        });
        state = true;
        return true;
      }

      final payload = UserInfo(
        id: id,
        displayName: displayName,
        email: email,
        profileImageUrl: profileImageUrl,
      ).toJson();
      await ref
          .watch(firestoreProvider)
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      state = true;
      return true;
    } catch (_) {
      state = false;
      return false;
    }
  }
}

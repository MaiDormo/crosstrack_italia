import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
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

  Future<void> saveUserInfo({
    required UserInfoModel userInfoModel,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await _firestore
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.id,
            isEqualTo: userInfoModel.id,
          )
          .limit(1)
          .get();

      if (userInfo.docs.isNotEmpty) {
        // we already have this user's profile, save the new data instead
        userInfo.docs.first.reference.update(
          userInfoModel.toJson(),
        );
        state = true;
        return;
      }

      final payload = userInfoModel.toJson();
      await ref
          .watch(firestoreProvider)
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      state = true;
    } catch (e) {
      print('DEBUG: $e');
      state = false;
    }
  }
}

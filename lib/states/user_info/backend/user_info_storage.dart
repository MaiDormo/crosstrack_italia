import 'package:crosstrack_italia/states/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/states/user_info/models/typedefs/user_id.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/states/user_info/models/user_info_payload.dart';
import 'package:flutter/foundation.dart' show immutable;

import '../../constants/firebase_field_name.dart';

@immutable
class UserInfoStorage {
  const UserInfoStorage();
  Future<bool> saveUserInfo({
    required UserId userId,
    required String displayName,
    required String? email,
    required String? profileImageUrl,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .where(
            FirebaseFieldName.userId,
            isEqualTo: userId,
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
        return true;
      }

      final payload = UserInfoPayload(
        userId: userId,
        displayName: displayName,
        email: email,
        profileImageUrl: profileImageUrl,
      );
      await FirebaseFirestore.instance
          .collection(
            FirebaseCollectionName.users,
          )
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
}

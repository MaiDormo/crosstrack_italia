import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
        final payload = userInfoModel.toJson();
        //removing id and favoriteTracks from payload
        //because id does not need to be updated
        //and favoriteTracks is updated separately
        payload.remove(FirebaseFieldName.id);
        payload.remove(FirebaseFieldName.favoriteTracks);
        await userInfo.docs.first.reference.update(payload);
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
      print('Error saving user info: $e');
      state = false;
    }
  }

  Future<void> deleteUserInfo() async {
    try {
      final user = ref.read(authProvider).currentUser!;
      final querySnapshot = await _firestore
          .collection(FirebaseCollectionName.users)
          .where(FirebaseFieldName.id, isEqualTo: user.uid)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        // Get the document reference
        final docRef = querySnapshot.docs.first.reference;

        // Delete the document
        await docRef.delete();
      }
      await user.delete();
    } on FirebaseAuthException catch (e) {
      // log.e(e);
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      // log.e(e);

      // Handle general exception
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData =
          ref.read(authProvider).currentUser?.providerData.first;

      if (FacebookAuthProvider().providerId == providerData!.providerId) {
        await ref
            .read(authProvider)
            .currentUser!
            .reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await ref
            .read(authProvider)
            .currentUser!
            .reauthenticateWithProvider(GoogleAuthProvider());
      }

      await ref.read(authProvider).currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }
}

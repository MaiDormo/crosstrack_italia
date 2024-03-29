import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/firebase_constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/firebase_constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_storage.g.dart';

@riverpod
UserInfoStorage userInfoStorage(UserInfoStorageRef ref) {
  final auth = ref.watch(authProvider);
  final firestore = ref.watch(firestoreProvider);

  return UserInfoStorage(
    auth: auth,
    firestore: firestore,
  );
}

class UserInfoStorage {
  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  const UserInfoStorage({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseCollectionName.users);

  Future<UserInfoModel> fetchUserInfo(UserId id) async {
    final userDocSnapshot = await _users.doc(id).get();

    if (userDocSnapshot.exists) {
      return UserInfoModel.fromJson(
          userDocSnapshot.data()! as Map<String, dynamic>);
    } else {
      return UserInfoModel.empty();
    }
  }

  Future<void> saveUserInfo({
    required UserInfoModel userInfoModel,
  }) async {
    try {
      // first check if we have this user's info from before
      final userInfo = await _users
          .doc(userInfoModel.id) // Use the user's ID as the document ID
          .get();

      final payload = userInfoModel.toJson();

      if (userInfo.exists) {
        await _updateUserInfo(userInfo.reference, payload);
      } else {
        await _createUserInfo(userInfoModel.id, payload);
      }
    } catch (e) {}
  }

  Future<void> _updateUserInfo(
      DocumentReference docRef, Map<String, dynamic> payload) async {
    //removing id and favoriteTracks from payload
    //because id does not need to be updated
    //and favoriteTracks is updated separately
    payload.remove(FirebaseFieldName.id);
    payload.remove(FirebaseFieldName.favoriteTracks);
    await docRef.update(payload);
  }

  Future<void> _createUserInfo(String id, Map<String, dynamic> payload) async {
    await _users.doc(id).set(payload);
  }

  Future<void> deleteUserInfo() async {
    try {
      final user = _auth.currentUser!;
      await _deleteUserDocument(user.uid);
      await user.delete();
    } on FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        // Handle other Firebase exceptions
      }
    } catch (e) {
      // Handle general exception
    }
  }

  Future<void> _deleteUserDocument(String userId) async {
    final documentSnapshot = await _users.doc(userId).get();

    if (documentSnapshot.exists) {
      await documentSnapshot.reference.delete();
    }
  }

  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData = _auth.currentUser?.providerData.first;

      if (FacebookAuthProvider().providerId == providerData!.providerId) {
        await _reauthenticateWithProvider(AppleAuthProvider());
      } else if (GoogleAuthProvider().providerId == providerData.providerId) {
        await _reauthenticateWithProvider(GoogleAuthProvider());
      }

      await _auth.currentUser?.delete();
    } catch (e) {
      // Handle exceptions
    }
  }

  Future<void> _reauthenticateWithProvider(AuthProvider provider) async {
    await _auth.currentUser!.reauthenticateWithProvider(provider);
  }
}

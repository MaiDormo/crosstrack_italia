import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/firebase_constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/firebase_constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/user_info/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_info_storage.g.dart';

/// Provides a [UserInfoStorage] instance with dependencies injected.
@riverpod
UserInfoStorage userInfoStorage(Ref ref) {
  final auth = ref.watch(authProvider);
  final firestore = ref.watch(firestoreProvider);

  return UserInfoStorage(
    auth: auth,
    firestore: firestore,
  );
}

/// Repository for managing user profile data in Firestore.
///
/// Handles CRUD operations for user information, including:
/// - Fetching user profiles
/// - Saving/updating user data
/// - Deleting user accounts (with reauthentication if needed)
///
/// Example usage:
/// ```dart
/// final storage = ref.watch(userInfoStorageProvider);
/// final userInfo = await storage.fetchUserInfo(userId);
/// ```
class UserInfoStorage {
  final firebase_auth.FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  /// Creates a new [UserInfoStorage] with the given Firebase dependencies.
  const UserInfoStorage({
    required firebase_auth.FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseCollectionName.users);

  /// Fetches user information from Firestore by user ID.
  ///
  /// [id] - The unique identifier of the user.
  ///
  /// Returns the [UserInfoModel] if found, or [UserInfoModel.empty()] if
  /// the user document doesn't exist.
  Future<UserInfoModel> fetchUserInfo(UserId id) async {
    final userDocSnapshot = await _users.doc(id).get();

    if (userDocSnapshot.exists) {
      return UserInfoModel.fromJson(
          userDocSnapshot.data()! as Map<String, dynamic>);
    } else {
      return UserInfoModel.empty();
    }
  }

  /// Saves or updates user information in Firestore.
  ///
  /// If the user document exists, it updates the existing data (excluding
  /// id and favoriteTracks which are managed separately).
  /// If the document doesn't exist, it creates a new one.
  ///
  /// [userInfoModel] - The user data to save.
  Future<void> saveUserInfo({
    required UserInfoModel userInfoModel,
  }) async {
    try {
      // First check if we have this user's info from before
      final userInfo = await _users
          .doc(userInfoModel.id) // Use the user's ID as the document ID
          .get();

      final payload = userInfoModel.toJson();

      if (userInfo.exists) {
        await _updateUserInfo(userInfo.reference, payload);
      } else {
        await _createUserInfo(userInfoModel.id, payload);
      }
    } catch (e) {
      debugPrint('Save user info error: $e');
    }
  }

  /// Updates an existing user document.
  ///
  /// Removes 'id' and 'favoriteTracks' from the payload as these fields
  /// are managed separately and should not be overwritten.
  Future<void> _updateUserInfo(
      DocumentReference docRef, Map<String, dynamic> payload) async {
    payload.remove(FirebaseFieldName.id);
    payload.remove(FirebaseFieldName.favoriteTracks);
    await docRef.update(payload);
  }

  /// Creates a new user document in Firestore.
  Future<void> _createUserInfo(String id, Map<String, dynamic> payload) async {
    await _users.doc(id).set(payload);
  }

  /// Deletes the current user's account and all associated data.
  ///
  /// This operation:
  /// 1. Deletes the user document from Firestore
  /// 2. Deletes the Firebase Auth account
  ///
  /// If the operation requires recent authentication, it will attempt
  /// to reauthenticate the user first.
  ///
  /// Does nothing if no user is currently logged in.
  Future<void> deleteUserInfo() async {
    try {
      final user = _auth.currentUser;
      if (user == null) {
        debugPrint('Delete user info error: No user logged in');
        return;
      }
      await _deleteUserDocument(user.uid);
      await user.delete();
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == "requires-recent-login") {
        await _reauthenticateAndDelete();
      } else {
        debugPrint('Delete user info Firebase error: ${e.code} - ${e.message}');
      }
    } catch (e) {
      debugPrint('Delete user info error: $e');
    }
  }

  /// Deletes the user document from Firestore if it exists.
  Future<void> _deleteUserDocument(String userId) async {
    final documentSnapshot = await _users.doc(userId).get();

    if (documentSnapshot.exists) {
      await documentSnapshot.reference.delete();
    }
  }

  /// Reauthenticates the user and then deletes their account.
  ///
  /// Required when the user's last sign-in was too long ago for
  /// sensitive operations like account deletion.
  Future<void> _reauthenticateAndDelete() async {
    try {
      final providerData = _auth.currentUser?.providerData.firstOrNull;
      if (providerData == null) {
        debugPrint('Reauthenticate error: No provider data available');
        return;
      }

      if (firebase_auth.FacebookAuthProvider().providerId == providerData.providerId) {
        await _reauthenticateWithProvider(firebase_auth.AppleAuthProvider());
      } else if (firebase_auth.GoogleAuthProvider().providerId == providerData.providerId) {
        await _reauthenticateWithProvider(firebase_auth.GoogleAuthProvider());
      }

      await _auth.currentUser?.delete();
    } catch (e) {
      debugPrint('Reauthenticate and delete error: $e');
    }
  }

  /// Reauthenticates the current user with the specified provider.
  Future<void> _reauthenticateWithProvider(firebase_auth.AuthProvider provider) async {
    final currentUser = _auth.currentUser;
    if (currentUser == null) {
      debugPrint('Reauthenticate error: No current user');
      return;
    }
    await currentUser.reauthenticateWithProvider(provider);
  }
}

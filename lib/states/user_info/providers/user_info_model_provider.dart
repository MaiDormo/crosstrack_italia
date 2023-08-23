// Import necessary libraries and dependencies
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/states/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/states/user_info/models/typedefs/user_id.dart';
import 'package:crosstrack_italia/states/user_info/models/user_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/firebase_field_name.dart';

// Define a Riverpod Provider for a Stream of UserInfoModel based on UserId
final userInfoModelProvider =
    StreamProvider.family.autoDispose<UserInfoModel, UserId>(
  (ref, UserId userId) {
    // Create a StreamController to manage the stream of UserInfoModel
    final controller = StreamController<UserInfoModel>();

    // Set up a Firestore query to listen for changes in user data
    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.users,
        )
        .where(
          FirebaseFieldName.userId,
          isEqualTo: userId,
        )
        .limit(1)
        .snapshots()
        .listen((snapshot) {
      // When the Firestore query snapshot updates
      if (snapshot.docs.isNotEmpty) {
        // Get the first document in the snapshot
        final doc = snapshot.docs.first;

        // Extract JSON data from the document
        final json = doc.data();

        // Create a UserInfoModel instance from the JSON data
        final userInfoModel = UserInfoModel.fromJson(
          json,
          userId: userId,
        );

        // Add the UserInfoModel to the stream
        controller.add(userInfoModel);
      }
    });

    // Define a cleanup action when the provider is disposed
    ref.onDispose(() {
      // Cancel the Firestore query subscription
      sub.cancel();
      // Close the StreamController
      controller.close();
    });

    // Return the stream of UserInfoModel
    return controller.stream;
  },
);

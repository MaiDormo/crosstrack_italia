import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/states/auth/providers/user_id_provider.dart';
import 'package:crosstrack_italia/states/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/states/posts/models/post.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/firebase_collection_name.dart';
import '../models/post_key.dart';

final userPostsProvider = StreamProvider.autoDispose<Iterable<Post>>((ref) {
  final controller = StreamController<Iterable<Post>>();

  final userId = ref.watch(userIdProvider);

  controller.onListen = () {
    controller.sink.add([]);
  };

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.posts)
      .orderBy(
        FirebaseFieldName.createdAt,
        descending: true,
      )
      .where(PostKey.userId, isEqualTo: userId)
      .snapshots()
      .listen((snapshots) {
    final documents = snapshots.docs;
    final posts = documents
        //we do not want to read the documents that have pending updates,
        //or pending write operations by firebase
        //solution: we simply filter those elements out
        .where(
          (doc) => !doc.metadata.hasPendingWrites,
        )
        .map(
          (doc) => Post(
            postId: doc.id,
            json: doc.data(),
          ),
        );
    controller.sink.add(posts);
  });

  //stream controller needs to be autodispose as soon as the provider
  //is not needed anymore
  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});

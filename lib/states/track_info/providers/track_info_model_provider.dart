import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/states/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/states/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/states/track_info/models/track_info_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/typedefs/track_types.dart';

final trackInfoModelProvider = StreamProvider.family
    .autoDispose<TrackInfoModel, TrackId>((ref, TrackId trackId) {
  final controller = StreamController<TrackInfoModel>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.tracks)
      .where(FirebaseFieldName.trackId, isEqualTo: trackId)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final trackInfoModel = TrackInfoModel(
        trackId: doc.id,
        json: json,
      );
      controller.add(trackInfoModel);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});

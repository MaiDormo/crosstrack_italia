import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track_info/models/track.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/typedefs/typedefs.dart';

final trackInfoModelProvider =
    StreamProvider.family.autoDispose<Track, TrackId>((ref, TrackId trackId) {
  final controller = StreamController<Track>();

  final sub = FirebaseFirestore.instance
      .collection(FirebaseCollectionName.tracks)
      .where(FirebaseFieldName.trackId, isEqualTo: trackId)
      .limit(1)
      .snapshots()
      .listen((snapshot) {
    if (snapshot.docs.isNotEmpty) {
      final doc = snapshot.docs.first;
      final json = doc.data();
      final trackInfoModel = Track.fromJson(json);
      controller.add(trackInfoModel);
    }
  });

  ref.onDispose(() {
    sub.cancel();
    controller.close();
  });

  return controller.stream;
});

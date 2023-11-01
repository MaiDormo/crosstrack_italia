import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';
import '../models/track_info_model.dart';

final allTrackInfoProvider =
    StreamProvider.autoDispose<Iterable<TrackInfoModel>>(
  (ref) {
    final controller = StreamController<Iterable<TrackInfoModel>>();

    final sub = FirebaseFirestore.instance
        .collection(
          FirebaseCollectionName.tracks,
        )
        .orderBy(
          FirebaseFieldName.region,
          descending: false,
        )
        .orderBy(
          FirebaseFieldName.trackName,
          descending: false,
        )
        .snapshots()
        .listen(
      (snapshot) {
        final trackInfoModels = snapshot.docs.map(
          (doc) => TrackInfoModel(
            json: doc.data(),
            trackId: doc.id,
          ),
        );
        controller.add(trackInfoModels);
      },
    );

    ref.onDispose(() {
      sub.cancel();
      controller.close();
    });

    return controller.stream;
  },
);

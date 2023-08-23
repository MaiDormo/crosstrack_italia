import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/states/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/states/track_info/models/track_info_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/firebase_collection_name.dart';

part 'lombardia_tracks_provider.g.dart';

@riverpod
Stream<Iterable<TrackInfoModel>> lombardiaTracks(
    LombardiaTracksRef ref) async* {
  final controller = StreamController<Iterable<TrackInfoModel>>();
  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.tracks,
      )
      .where(
        FirebaseFieldName.region,
        isEqualTo: 'Lombardia',
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

  yield* controller.stream;
}

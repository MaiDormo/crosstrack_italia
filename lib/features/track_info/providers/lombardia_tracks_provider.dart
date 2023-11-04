import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track_info/models/track.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../constants/firebase_collection_name.dart';

part 'lombardia_tracks_provider.g.dart';

@riverpod
Stream<Iterable<Track>> lombardiaTracks(LombardiaTracksRef ref) async* {
  final controller = StreamController<Iterable<Track>>();
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
        (doc) => Track.fromJson(
          doc.data(),
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

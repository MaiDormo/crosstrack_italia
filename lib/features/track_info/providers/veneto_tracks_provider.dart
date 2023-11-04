import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track_info/models/track.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'veneto_tracks_provider.g.dart';

@riverpod
Stream<Iterable<Track>> venetoTracks(VenetoTracksRef ref) async* {
  final controller = StreamController<Iterable<Track>>();
  final sub = FirebaseFirestore.instance
      .collection(
        FirebaseCollectionName.tracks,
      )
      .where(
        FirebaseFieldName.region,
        isEqualTo: 'Veneto',
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

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../constants/firebase_collection_name.dart';
import '../../constants/firebase_field_name.dart';
import '../models/track.dart';

final allTrackInfoProvider = StreamProvider.autoDispose<Iterable<Track>>(
  (ref) {
    final controller = StreamController<Iterable<Track>>();

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

    return controller.stream;
  },
);

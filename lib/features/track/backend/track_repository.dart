import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_repository.g.dart';

@riverpod
TrackRepository trackRepository(TrackRepositoryRef ref) {
  return TrackRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

///TODO: add / remove / comment

class TrackRepository {
  final FirebaseFirestore _firestore;
  TrackRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _tracks =>
      _firestore.collection(FirebaseCollectionName.tracks);
  CollectionReference get _users =>
      _firestore.collection(FirebaseCollectionName.users);
  CollectionReference get _comments =>
      _firestore.collection(FirebaseCollectionName.comments);

  Stream<Iterable<Track>> fetchAllTracks() {
    return _tracks
        .orderBy(FirebaseFieldName.region, descending: false)
        .orderBy(FirebaseFieldName.trackName, descending: false)
        .snapshots()
        .map((event) => event.docs.map(
              (e) => Track.fromJson(e.data() as Map<String, dynamic>),
            ));
  }

  Stream<Iterable<Track>> fetchTracksByRegion(String region) {
    return _tracks
        .where(FirebaseFieldName.region, isEqualTo: region)
        .orderBy(FirebaseFieldName.trackName, descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Track.fromJson(doc.data() as Map<String, dynamic>)));
  }
}

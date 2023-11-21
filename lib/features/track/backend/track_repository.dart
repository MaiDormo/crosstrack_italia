import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/common/failure.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';

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
  // CollectionReference get _users =>
  //     _firestore.collection(FirebaseCollectionName.users);
  CollectionReference get _comments =>
      _firestore.collection(FirebaseCollectionName.comments);

  //Firebase call to get all tracks
  Stream<Iterable<Track>> fetchAllTracks() {
    return _tracks
        .orderBy(FirebaseFieldName.region, descending: false)
        .orderBy(FirebaseFieldName.trackName, descending: false)
        .snapshots()
        .map((event) => event.docs.map(
              (e) => Track.fromJson(e.data() as Map<String, dynamic>),
            ));
  }

  //Firebase call to get all tracks by region
  Stream<Iterable<Track>> fetchTracksByRegion(String region) {
    return _tracks
        .where(FirebaseFieldName.region, isEqualTo: region)
        .orderBy(FirebaseFieldName.trackName, descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Track.fromJson(doc.data() as Map<String, dynamic>)));
  }

  // Firebase call to get all comment related to a track
  Stream<Iterable<Comment>> fetchCommentsByTrackId(TrackId trackId) {
    return _comments
        .where(FirebaseFieldName.trackId, isEqualTo: trackId)
        .orderBy(FirebaseFieldName.date, descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
            (doc) => Comment.fromJson(doc.data() as Map<String, dynamic>)));
  }

  //Firebase call to get all comment related to a trackName

  //add comment
  Future<Either<Failure, void>> addComment(Comment comment) async {
    try {
      await _comments.doc(comment.commentId).set(comment.toJson());
      // return right(_tracks.doc(comment.commentId).update({
      //   FirebaseFieldName.commentCount: FieldValue.increment(1),
      // }));
      return right(unit);
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //remove comment
  // Future<void> removeComment(Comment comment) async {

  // }
}

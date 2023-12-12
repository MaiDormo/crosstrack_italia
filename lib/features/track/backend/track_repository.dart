import 'dart:math';

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
  Stream<Iterable<Comment>> fetchCommentsByTrackId(TrackId id) {
    return _comments
        .where(FirebaseFieldName.id, isEqualTo: id)
        .orderBy(FirebaseFieldName.date, descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
            (doc) => Comment.fromJson(doc.data() as Map<String, dynamic>)));
  }

  //add comment
  Future<Either<Failure, void>> addComment(Comment comment) async {
    try {
      await _comments.doc(comment.commentId).set(comment.toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  // remove comment
  Future<Either<Failure, void>> removeComment(Comment comment) async {
    try {
      await _comments.doc(comment.commentId).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //update track
  Future<Either<Failure, void>> updateTrack(Track newTrack) async {
    try {
      await _tracks.doc(newTrack.id).update(newTrack.toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      throw e;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  //fetch all tracks from a list of string ids
  Future<Either<Failure, Iterable<Track>>> fetchTracksByIds(
      Iterable<TrackId> ids) async {
    if (ids.isEmpty) return Right([]);

    try {
      List<Track> tracks = [];
      for (var chunk in partition(ids.toList(), 10)) {
        final querySnapshot = await _tracks
            .where(FirebaseFieldName.id, whereIn: chunk.toList())
            .get();
        tracks.addAll(querySnapshot.docs
            .map((doc) => Track.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
      }
      return Right(tracks);
    } catch (e) {
      return Left(Failure(e.toString()));
    }
  }
}

List<List<T>> partition<T>(List<T> list, int size) {
  return List.generate((list.length / size).ceil(), (index) {
    int start = index * size;
    int end = min(start + size, list.length);
    return list.sublist(start, end);
  });
}

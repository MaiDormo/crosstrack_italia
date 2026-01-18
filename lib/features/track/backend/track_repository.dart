import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/common/failure.dart';
import 'package:crosstrack_italia/features/firebase_constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/firebase_constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:fpdart/fpdart.dart';

part 'track_repository.g.dart';

/// Provides a [TrackRepository] instance with Firestore dependency injected.
@riverpod
TrackRepository trackRepository(TrackRepositoryRef ref) {
  return TrackRepository(
    firestore: ref.watch(firestoreProvider),
  );
}

/// Repository for managing motocross track data in Firestore.
///
/// This repository provides CRUD operations for tracks and their associated
/// comments. All operations use Firebase Firestore as the backend.
///
/// Example usage:
/// ```dart
/// final repo = ref.watch(trackRepositoryProvider);
/// final tracks = repo.fetchAllTracks();
/// ```
class TrackRepository {
  final FirebaseFirestore _firestore;

  /// Creates a new [TrackRepository] with the given Firestore instance.
  TrackRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _tracks =>
      _firestore.collection(FirebaseCollectionName.tracks);
  CollectionReference get _comments =>
      _firestore.collection(FirebaseCollectionName.comments);

  /// Fetches all tracks from Firestore as a real-time stream.
  ///
  /// Tracks are ordered by region (ascending) and then by track name (ascending).
  ///
  /// Returns a [Stream] that emits an [Iterable] of [Track] objects whenever
  /// the underlying data changes.
  Stream<Iterable<Track>> fetchAllTracks() {
    return _tracks
        .orderBy(FirebaseFieldName.region, descending: false)
        .orderBy(FirebaseFieldName.trackName, descending: false)
        .snapshots()
        .map((event) => event.docs.map(
              (e) => Track.fromJson(e.data() as Map<String, dynamic>),
            ));
  }

  /// Fetches all comments for a specific track as a real-time stream.
  ///
  /// Comments are ordered by date (ascending - oldest first).
  ///
  /// [trackId] - The unique identifier of the track to fetch comments for.
  ///
  /// Returns a [Stream] that emits an [Iterable] of [Comment] objects.
  Stream<Iterable<Comment>> fetchCommentsByTrackId(TrackId trackId) {
    return _comments
        .where(FirebaseFieldName.trackId, isEqualTo: trackId)
        .orderBy(FirebaseFieldName.date, descending: false)
        .snapshots()
        .map((snapshot) => snapshot.docs.map(
            (doc) => Comment.fromJson(doc.data() as Map<String, dynamic>)));
  }

  /// Adds a new comment to Firestore.
  ///
  /// [comment] - The comment to add, must have a unique ID.
  ///
  /// Returns [Right] with unit on success, or [Left] with a [Failure] on error.
  Future<Either<Failure, void>> addComment(Comment comment) async {
    try {
      await _comments.doc(comment.id).set(comment.toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      return left(Failure('Firebase error: ${e.message}'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /// Removes a comment from Firestore.
  ///
  /// [comment] - The comment to remove (uses comment.id for deletion).
  ///
  /// Returns [Right] with unit on success, or [Left] with a [Failure] on error.
  Future<Either<Failure, void>> removeComment(Comment comment) async {
    try {
      await _comments.doc(comment.id).delete();
      return right(unit);
    } on FirebaseException catch (e) {
      return left(Failure('Firebase error: ${e.message}'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /// Calculates the new average rating when a comment is added or removed.
  ///
  /// Uses weighted average formula to efficiently update the rating without
  /// recalculating from all comments.
  ///
  /// [oldRating] - The current average rating of the track.
  /// [oldCommentCount] - The current number of comments.
  /// [rating] - The rating being added or removed.
  /// [isAdd] - True if adding a rating, false if removing.
  ///
  /// Returns the new calculated average rating.
  double calculateNewRating(
      double oldRating, int oldCommentCount, double rating, bool isAdd) {
    return isAdd
        ? (oldRating * oldCommentCount + rating) / (oldCommentCount + 1)
        : oldCommentCount != 1
            ? (oldRating * oldCommentCount - rating) / (oldCommentCount - 1)
            : 0.0;
  }

  /// Updates an existing track in Firestore.
  ///
  /// [newTrack] - The track with updated data. Uses track.id to identify
  /// the document to update.
  ///
  /// Returns [Right] with unit on success, or [Left] with a [Failure] on error.
  Future<Either<Failure, void>> updateTrack(Track newTrack) async {
    try {
      await _tracks.doc(newTrack.id).update(newTrack.toJson());
      return right(unit);
    } on FirebaseException catch (e) {
      return left(Failure('Firebase error: ${e.message}'));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  /// Fetches multiple tracks by their IDs.
  ///
  /// Uses batching to handle Firestore's 10-item limit on `whereIn` queries.
  ///
  /// [ids] - Collection of track IDs to fetch.
  ///
  /// Returns [Right] with the matching tracks, or [Left] with a [Failure] on error.
  /// Returns an empty list if [ids] is empty.
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

/// Splits a list into chunks of the specified size.
///
/// Useful for working around Firestore's query limitations (e.g., `whereIn`
/// supports maximum 10 items).
///
/// [list] - The list to partition.
/// [size] - Maximum size of each chunk.
///
/// Returns a list of lists, where each inner list has at most [size] elements.
List<List<T>> partition<T>(List<T> list, int size) {
  return List.generate((list.length / size).ceil(), (index) {
    int start = index * size;
    int end = min(start + size, list.length);
    return list.sublist(start, end);
  });
}

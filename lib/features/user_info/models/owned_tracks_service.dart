import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';

class OwnedTracksService {
  final FirebaseFirestore _firestore;
  final String _userId;

  OwnedTracksService(
      {required FirebaseFirestore firestore, required String userId})
      : _firestore = firestore,
        _userId = userId;

  Future<void> addTracks(List<TrackId> trackIds) {
    return _firestore.runTransaction((transaction) async {
      final userDocRef =
          _firestore.collection(FirebaseCollectionName.users).doc(_userId);

      final userDocSnapshot = await transaction.get(userDocRef);

      if (!userDocSnapshot.exists) {
        throw Exception('User not found');
      }

      List<dynamic> ownedTracks =
          userDocSnapshot.get(FirebaseFieldName.ownedTracks) ?? [];
      ownedTracks.addAll(trackIds);
      transaction
          .update(userDocRef, {FirebaseFieldName.ownedTracks: ownedTracks});
    });
  }

  Future<void> removeTrack(TrackId trackId) {
    return _firestore.runTransaction((transaction) async {
      final userDocRef =
          _firestore.collection(FirebaseCollectionName.users).doc(_userId);

      final userDocSnapshot = await transaction.get(userDocRef);

      if (!userDocSnapshot.exists) {
        throw Exception('User not found');
      }

      transaction.update(userDocRef, {
        FirebaseFieldName.ownedTracks: FieldValue.arrayRemove([trackId])
      });
    });
  }

  Future<List<TrackId>> getOwnedTracks() async {
    return _firestore.runTransaction<List<TrackId>>((
      Transaction transaction,
    ) async {
      final userDocRef =
          _firestore.collection(FirebaseCollectionName.users).doc(_userId);

      final userDocSnapshot = await transaction.get(userDocRef);

      if (!userDocSnapshot.exists && userDocSnapshot.data() == null) {
        return [];
      }

      return (userDocSnapshot.data()?[FirebaseFieldName.ownedTracks] as List?)
              ?.cast<TrackId>() ??
          [];
    });
  }

  Future<void> updateTrackInfo(Track updatedTrack) {
    return _firestore.runTransaction((transaction) async {
      final trackQuery = _firestore
          .collection(FirebaseCollectionName.tracks)
          .where(FirebaseFieldName.id, isEqualTo: updatedTrack.id);

      final trackQuerySnapshot = await trackQuery.get();
      if (trackQuerySnapshot.docs.isEmpty) {
        return;
      }

      final trackDocRef = trackQuerySnapshot.docs.first.reference;

      transaction.update(trackDocRef, updatedTrack.toJson());
    });
  }
}

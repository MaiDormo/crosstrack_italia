import 'package:cloud_firestore/cloud_firestore.dart';
import '../../firebase_constants/firebase_collection_name.dart';
import '../../firebase_constants/firebase_field_name.dart';
import '../../track/models/track.dart';
import '../../track/models/typedefs/typedefs.dart';

class OwnedTracksRepository {

  OwnedTracksRepository(
      {required FirebaseFirestore firestore, required String userId})
      : _firestore = firestore,
        _userId = userId;
      
  final FirebaseFirestore _firestore;
  final String _userId;

  CollectionReference get _users =>
      _firestore.collection(FirebaseCollectionName.users);

  CollectionReference get _tracks =>
      _firestore.collection(FirebaseCollectionName.tracks);

  Future<void> addTracks(List<TrackId> trackIds) {
    return _firestore.runTransaction((transaction) async {
      final userDocRef = _users.doc(_userId);

      final userDocSnapshot = await transaction.get(userDocRef);

      if (!userDocSnapshot.exists) {
        throw Exception('User not found');
      }

      final List<dynamic> ownedTracks =
          userDocSnapshot.get(FirebaseFieldName.ownedTracks) ?? [];
      ownedTracks.addAll(trackIds);
      transaction
          .update(userDocRef, {FirebaseFieldName.ownedTracks: ownedTracks});
    });
  }

  Future<void> removeTrack(TrackId trackId) {
    return _firestore.runTransaction((transaction) async {
      final userDocRef = _users.doc(_userId);

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
      final userDocRef = _users.doc(_userId);

      final userDocSnapshot = await transaction.get(userDocRef);

      if (!userDocSnapshot.exists && userDocSnapshot.data() == null) {
        return [];
      }

      //needed to cast because cannot infer type from Object? to Map<String, dynamic>
      final data = userDocSnapshot.data() as Map<String, dynamic>;

      return (data[FirebaseFieldName.ownedTracks] as List?)?.cast<TrackId>() ??
          [];
    });
  }

  Future<void> updateTrackInfo(Track updatedTrack) {
    return _firestore.runTransaction((transaction) async {
      final trackQuery =
          _tracks.where(FirebaseFieldName.id, isEqualTo: updatedTrack.id);

      final trackQuerySnapshot = await trackQuery.get();
      if (trackQuerySnapshot.docs.isEmpty) {
        return;
      }

      final trackDocRef = trackQuerySnapshot.docs.first.reference;

      transaction.update(trackDocRef, updatedTrack.toJson());
    });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/features/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/features/constants/firebase_field_name.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';

abstract class FavoriteTracksService {
  Future<void> addTrack(TrackId trackId);
  Future<void> removeTrack(TrackId trackId);
  Future<List<TrackId>> getFavoriteTracks();
}

class FirebaseFavoriteTracksService implements FavoriteTracksService {
  final FirebaseFirestore _firestore;
  final String _userId;

  FirebaseFavoriteTracksService(
      {required FirebaseFirestore firestore, required String userId})
      : _firestore = firestore,
        _userId = userId;

  @override
  Future<void> addTrack(TrackId trackId) {
    return _firestore.runTransaction((transaction) async {
      final userQuery =
          _firestore.collection(FirebaseCollectionName.users).doc(_userId);

      final userDocument = await userQuery.get();
      if (!userDocument.exists) {
        throw Exception('User not found');
      }

      final userDocRef = userDocument.reference;

      final userDocSnapshot = await transaction.get(userDocRef);

      List<dynamic> favoriteTracks =
          userDocSnapshot.get(FirebaseFieldName.favoriteTracks) ?? [];
      favoriteTracks.add(trackId);
      transaction.update(
          userDocRef, {FirebaseFieldName.favoriteTracks: favoriteTracks});
    });
  }

  @override
  Future<void> removeTrack(TrackId trackId) {
    return _firestore.runTransaction((transaction) async {
      final userDocRef = _firestore
          .collection(FirebaseCollectionName.users)
          .doc(_userId); // Use _userId as the document ID

      final userDocSnapshot = await userDocRef.get();
      if (!userDocSnapshot.exists) {
        throw Exception('User not found');
      }

      transaction.update(userDocRef, {
        FirebaseFieldName.favoriteTracks: FieldValue.arrayRemove([trackId])
      });
    });
  }

  @override
  Future<List<TrackId>> getFavoriteTracks() async {
    final docSnapshot = await _firestore
        .collection(FirebaseCollectionName.users)
        .doc(_userId) // Use _userId as the document ID
        .get();

    if (!docSnapshot.exists && docSnapshot.data() == null) {
      return [];
    }

    return (docSnapshot.data()![FirebaseFieldName.favoriteTracks] as List?)
            ?.cast<TrackId>() ??
        [];
  }
}

class SharedPrefsFavoriteTracksService implements FavoriteTracksService {
  @override
  Future<void> addTrack(TrackId trackId) async {
    final prefs = await SharedPreferences.getInstance();
    final tracks = prefs.getStringList(FirebaseFieldName.favoriteTracks) ?? [];
    tracks.add(trackId);
    await prefs.setStringList(FirebaseFieldName.favoriteTracks, tracks);
  }

  @override
  Future<void> removeTrack(TrackId trackId) async {
    final prefs = await SharedPreferences.getInstance();
    final tracks = prefs.getStringList(FirebaseFieldName.favoriteTracks) ?? [];
    tracks.remove(trackId);
    await prefs.setStringList(FirebaseFieldName.favoriteTracks, tracks);
  }

  @override
  Future<List<TrackId>> getFavoriteTracks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs
            .getStringList(FirebaseFieldName.favoriteTracks)
            ?.cast<TrackId>() ??
        [];
  }
}

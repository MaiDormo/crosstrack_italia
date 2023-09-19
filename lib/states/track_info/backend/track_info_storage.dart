import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crosstrack_italia/states/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/states/constants/firebase_field_name.dart';
import 'package:crosstrack_italia/states/track_info/models/track_info_payload.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';

import '../models/typedefs/track_types.dart';

@immutable
class TrackInfoStorage {
  const TrackInfoStorage();
  Future<bool> saveTrackInfo({
    required TrackId? trackId,
    required String trackName,
    required String region,
    required String location,
    required String motoclub,
    required String? category,
    required List<String>? acceptedLicenses,
    required String? terrainType,
    required String? trackLength,
    required String? hasMinicross,
    required Map<String, String>? services,
    required List<String>? phones,
    required List<String>? fax,
    required String? email,
    required String? website,
    required String? info,
    required Map<String, String>? openingHours,
    required String latitude,
    required String longitude,
    required String trackWebCode,
    required String photosUrl,
  }) async {
    try {
      //first check if we have this track's info from before
      final trackInfo = await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tracks)
          .where(FirebaseFieldName.trackId, isEqualTo: trackId)
          .limit(1)
          .get();

      if (trackInfo.docs.isNotEmpty) {
        //if we have it, update it
        await trackInfo.docs.first.reference.update({
          FirebaseFieldName.trackName: trackName,
          FirebaseFieldName.region: region,
          FirebaseFieldName.location: location,
          FirebaseFieldName.motoclub: motoclub,
          FirebaseFieldName.category: category ?? '',
          FirebaseFieldName.acceptedLicenses: acceptedLicenses ?? [],
          FirebaseFieldName.terrainType: terrainType ?? '',
          FirebaseFieldName.trackLength: trackLength ?? '',
          FirebaseFieldName.hasMinicross: hasMinicross ?? 'no',
          FirebaseFieldName.services: services ?? {},
          FirebaseFieldName.phones: phones ?? {},
          FirebaseFieldName.fax: fax ?? {},
          FirebaseFieldName.email: email ?? '',
          FirebaseFieldName.website: website ?? '',
          FirebaseFieldName.info: info ?? '',
          FirebaseFieldName.openingHours: openingHours ?? {},
          FirebaseFieldName.latitude: latitude,
          FirebaseFieldName.longitude: longitude,
          FirebaseFieldName.trackWebCode: trackWebCode,
          FirebaseFieldName.photosUrl: photosUrl,
        });
      }

      final payload = TrackInfoPayload(
        trackId: trackId,
        trackName: trackName,
        region: region,
        location: location,
        motoclub: motoclub,
        category: category,
        acceptedLicenses: acceptedLicenses,
        terrainType: terrainType,
        trackLength: trackLength,
        hasMinicross: hasMinicross,
        services: services,
        phones: phones,
        fax: fax,
        email: email,
        website: website,
        info: info,
        openingHours: openingHours,
        latitude: latitude,
        longitude: longitude,
        trackWebCode: trackWebCode,
        photosUrl: photosUrl,
      );
      await FirebaseFirestore.instance
          .collection(FirebaseCollectionName.tracks)
          .add(payload);
      return true;
    } catch (_) {
      return false;
    }
  }
}

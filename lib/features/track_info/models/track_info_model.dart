import 'package:crosstrack_italia/features/track_info/models/typedefs/typedefs.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:latlong2/latlong.dart';

import '../../constants/firebase_field_name.dart';

@immutable
class TrackInfoModel {
  final TrackId? trackId;
  final String trackName;
  final String region;
  final String location;
  final String motoclub;
  final String? category;
  final List<String>? acceptedLicenses;
  final String? terrainType;
  final String? trackLength;
  final String? hasMinicross;
  final Map<String, String>? services;
  final List<String>? phones;
  final List<String>? fax;
  final String? email;
  final String? website;
  final String? info;
  final Map<String, String>? openingHours;
  final LatLng coordinates;
  final String trackWebCode;
  final String photosUrl;

  TrackInfoModel({
    required this.trackId,
    Map<String, dynamic>? json,
  })  : trackName = json?[FirebaseFieldName.trackName],
        region = json?[FirebaseFieldName.region],
        location = json?[FirebaseFieldName.location],
        motoclub = json?[FirebaseFieldName.motoclub],
        category = json?[FirebaseFieldName.category] ?? '',
        acceptedLicenses =
            (json?[FirebaseFieldName.acceptedLicenses] as List<dynamic>)
                .cast<String>(),
        terrainType = json?[FirebaseFieldName.terrainType] ?? '',
        trackLength = json?[FirebaseFieldName.trackLength] ?? '0.0',
        hasMinicross = json?[FirebaseFieldName.hasMinicross] ?? 'no',
        services = (json?[FirebaseFieldName.services] as Map<String, dynamic>)
            .map((key, value) => MapEntry(key, value.toString())),
        phones = (json?[FirebaseFieldName.phones] as List<dynamic>?)
            ?.map((value) => value.toString()) // Convert values to strings
            .toList(),
        fax = (json?[FirebaseFieldName.fax] as List<dynamic>?)
            ?.map((value) => value.toString()) // Convert values to strings
            .toList(),
        email = json?[FirebaseFieldName.email] ?? '',
        website = json?[FirebaseFieldName.website] ?? '',
        info = json?[FirebaseFieldName.info] ?? '',
        openingHours =
            (json?[FirebaseFieldName.openingHours] as Map<String, dynamic>?)
                    ?.map((key, value) => MapEntry(key, value.toString())) ??
                {},
        coordinates = LatLng(
          double.parse(json?[FirebaseFieldName.latitude] ?? '0.0'),
          double.parse(json?[FirebaseFieldName.longitude] ?? '0.0'),
        ),
        trackWebCode = json?[FirebaseFieldName.trackWebCode],
        photosUrl = json?[FirebaseFieldName.photosUrl];
}

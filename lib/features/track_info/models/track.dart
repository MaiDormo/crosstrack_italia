import 'package:crosstrack_italia/features/track_info/models/typedefs/typedefs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../constants/firebase_field_name.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
class Track with _$Track {
  factory Track({
    required TrackId trackId,
    @JsonKey(name: FirebaseFieldName.trackName) required String trackName,
    @JsonKey(name: FirebaseFieldName.region) required String region,
    @JsonKey(name: FirebaseFieldName.location) required String location,
    @JsonKey(name: FirebaseFieldName.motoclub) required String motoclub,
    @JsonKey(name: FirebaseFieldName.category) @Default('') String? category,
    @JsonKey(name: FirebaseFieldName.acceptedLicenses)
    @Default([])
    List<String>? acceptedLicenses,
    @JsonKey(name: FirebaseFieldName.terrainType)
    @Default('')
    String? terrainType,
    @JsonKey(name: FirebaseFieldName.trackLength)
    @Default('')
    String? trackLength,
    @JsonKey(name: FirebaseFieldName.hasMinicross)
    @Default('')
    String? hasMinicross,
    @JsonKey(name: FirebaseFieldName.services)
    @Default({})
    Map<String, String>? services,
    @JsonKey(name: FirebaseFieldName.phones) @Default([]) List<String>? phones,
    @JsonKey(name: FirebaseFieldName.fax) @Default([]) List<String>? fax,
    @JsonKey(name: FirebaseFieldName.email) @Default('') String? email,
    @JsonKey(name: FirebaseFieldName.website) @Default('') String? website,
    @JsonKey(name: FirebaseFieldName.info) @Default('') String? info,
    @JsonKey(name: FirebaseFieldName.openingHours)
    @Default({})
    Map<String, String>? openingHours,
    @JsonKey(name: FirebaseFieldName.latitude) required double latitude,
    @JsonKey(name: FirebaseFieldName.longitude) required double longitude,
    @JsonKey(name: FirebaseFieldName.trackWebCode) required String trackWebCode,
    @JsonKey(name: FirebaseFieldName.photosUrl) required String photosUrl,
  }) = _Track;

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}

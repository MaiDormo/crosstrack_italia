import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../firebase_constants/firebase_field_name.dart';

part 'track.freezed.dart';
part 'track.g.dart';

@freezed
class Track with _$Track {
  factory Track({
    @Default('') TrackId id,
    @JsonKey(name: FirebaseFieldName.trackName) @Default('') String trackName,
    @JsonKey(name: FirebaseFieldName.region) @Default('') String region,
    @JsonKey(name: FirebaseFieldName.location) @Default('') String location,
    @JsonKey(name: FirebaseFieldName.motoclub) @Default('') String motoclub,
    @JsonKey(name: FirebaseFieldName.category) @Default('') String category,
    @JsonKey(name: FirebaseFieldName.acceptedLicenses)
    @Default([])
    List<TrackLicense> acceptedLicenses,
    @JsonKey(name: FirebaseFieldName.terrainType)
    @Default('')
    String terrainType,
    @JsonKey(name: FirebaseFieldName.trackLength)
    @Default('')
    String trackLength,
    @JsonKey(name: FirebaseFieldName.hasMinicross)
    @Default('no')
    String hasMinicross,
    @JsonKey(name: FirebaseFieldName.services)
    @Default({})
    Map<String, String>? services,
    @JsonKey(name: FirebaseFieldName.phones) @Default([]) List<String> phones,
    @JsonKey(name: FirebaseFieldName.fax) @Default([]) List<String> fax,
    @JsonKey(name: FirebaseFieldName.email) @Default('') String email,
    @JsonKey(name: FirebaseFieldName.website) @Default('') String website,
    @JsonKey(name: FirebaseFieldName.info) @Default('') String info,
    @JsonKey(name: FirebaseFieldName.latitude) @Default('0.0') String latitude,
    @JsonKey(name: FirebaseFieldName.longitude)
    @Default('0.0')
    String longitude,
    @JsonKey(name: FirebaseFieldName.photosUrl) @Default('') String photosUrl,
    @JsonKey(name: FirebaseFieldName.commentCount) @Default(0) int commentCount,
    @JsonKey(name: FirebaseFieldName.rating) @Default(0.0) double rating,
  }) = _Track;

  factory Track.empty() => Track();

  factory Track.fromJson(Map<String, dynamic> json) => _$TrackFromJson(json);
}

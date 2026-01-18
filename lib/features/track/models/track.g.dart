// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Track _$TrackFromJson(Map<String, dynamic> json) => _Track(
  id: json['id'] as String? ?? '',
  trackName: json['nome'] as String? ?? '',
  region: json['regione'] as String? ?? '',
  location: json['posto'] as String? ?? '',
  motoclub: json['motoclub'] as String? ?? '',
  category: json['categoria'] as String? ?? '',
  acceptedLicenses:
      (json['omologazione'] as List<dynamic>?)
          ?.map((e) => $enumDecode(_$TrackLicenseEnumMap, e))
          .toList() ??
      const [],
  terrainType: json['terreno'] as String? ?? '',
  trackLength: json['lunghezza'] as String? ?? '',
  hasMinicross: json['minicross'] as String? ?? 'no',
  services:
      (json['servizi'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, e as String),
      ) ??
      const {},
  phones:
      (json['telefono'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  fax:
      (json['fax'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  email: json['email'] as String? ?? '',
  website: json['sito_web'] as String? ?? '',
  info: json['orari_e_info'] as String? ?? '',
  latitude: json['latitudine'] as String? ?? '0.0',
  longitude: json['longitudine'] as String? ?? '0.0',
  photosUrl: json['foto'] as String? ?? '',
  commentCount: (json['numero_commenti'] as num?)?.toInt() ?? 0,
  rating: (json['valutazione'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$TrackToJson(_Track instance) => <String, dynamic>{
  'id': instance.id,
  'nome': instance.trackName,
  'regione': instance.region,
  'posto': instance.location,
  'motoclub': instance.motoclub,
  'categoria': instance.category,
  'omologazione': instance.acceptedLicenses
      .map((e) => _$TrackLicenseEnumMap[e]!)
      .toList(),
  'terreno': instance.terrainType,
  'lunghezza': instance.trackLength,
  'minicross': instance.hasMinicross,
  'servizi': instance.services,
  'telefono': instance.phones,
  'fax': instance.fax,
  'email': instance.email,
  'sito_web': instance.website,
  'orari_e_info': instance.info,
  'latitudine': instance.latitude,
  'longitudine': instance.longitude,
  'foto': instance.photosUrl,
  'numero_commenti': instance.commentCount,
  'valutazione': instance.rating,
};

const _$TrackLicenseEnumMap = {
  TrackLicense.uisp: 'uisp',
  TrackLicense.fmi: 'fmi',
  TrackLicense.csen: 'csen',
  TrackLicense.asc: 'asc',
  TrackLicense.asi: 'asi',
  TrackLicense.aics: 'aics',
};

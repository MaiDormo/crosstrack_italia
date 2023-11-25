// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'track.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TrackImpl _$$TrackImplFromJson(Map<String, dynamic> json) => _$TrackImpl(
      id: json['id'] as String? ?? '',
      trackName: json['nome'] as String? ?? '',
      region: json['regione'] as String? ?? '',
      location: json['posto'] as String? ?? '',
      motoclub: json['motoclub'] as String? ?? '',
      category: json['categoria'] as String? ?? '',
      acceptedLicenses: (json['omologazione'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      terrainType: json['terreno'] as String? ?? '',
      trackLength: json['lunghezza'] as String? ?? '',
      hasMinicross: json['minicross'] as String? ?? 'no',
      services: (json['servizi'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      phones: (json['telefono'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      fax: (json['fax'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      email: json['email'] as String? ?? '',
      website: json['sito_web'] as String? ?? '',
      info: json['orari_e_info'] as String? ?? '',
      openingHours: (json['apertura'] as Map<String, dynamic>?)?.map(
            (k, e) => MapEntry(k, e as String),
          ) ??
          const {},
      latitude: json['latitudine'] as String? ?? '0.0',
      longitude: json['longitudine'] as String? ?? '0.0',
      photosUrl: json['foto'] as String? ?? '',
      commentCount: json['numero_commenti'] as int? ?? 0,
      rating: (json['valutazione'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$$TrackImplToJson(_$TrackImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'nome': instance.trackName,
      'regione': instance.region,
      'posto': instance.location,
      'motoclub': instance.motoclub,
      'categoria': instance.category,
      'omologazione': instance.acceptedLicenses,
      'terreno': instance.terrainType,
      'lunghezza': instance.trackLength,
      'minicross': instance.hasMinicross,
      'servizi': instance.services,
      'telefono': instance.phones,
      'fax': instance.fax,
      'email': instance.email,
      'sito_web': instance.website,
      'orari_e_info': instance.info,
      'apertura': instance.openingHours,
      'latitudine': instance.latitude,
      'longitudine': instance.longitude,
      'foto': instance.photosUrl,
      'numero_commenti': instance.commentCount,
      'valutazione': instance.rating,
    };

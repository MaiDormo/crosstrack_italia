import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  //shared
  static const id = 'id';
  static const userId = 'userId';
  static const trackId = 'trackId';
  //still need to a dd all of the field names
  static const displayName = 'display_name';
  static const createdAt = 'created_at';
  static const email = 'email';
  static const profileImageUrl = 'profile_image_url';
  static const favoriteTracks = 'favorite_tracks';
  static const ownedTracks = 'owned_tracks';

  //track info
  static const trackName = 'nome';
  static const location = 'posto';
  static const region = 'regione';
  static const motoclub = 'motoclub';
  static const category = 'categoria';
  static const acceptedLicenses = 'omologazione';
  static const terrainType = 'terreno';
  static const trackLength = 'lunghezza';
  static const hasMinicross = 'minicross';
  static const services = 'servizi';
  static const phones = 'telefono';
  static const fax = 'fax';
  static const trackEmail = 'email';
  static const website = 'sito_web';
  static const info = 'orari_e_info';
  static const latitude = 'latitudine';
  static const longitude = 'longitudine';
  static const images = 'immagini';
  static const photosUrl = 'foto';
  static const commentCount = 'numero_commenti';
  static const rating = 'valutazione';

  //comment info
  static const comment = 'comment';
  static const date = 'date';

  const FirebaseFieldName._();
}

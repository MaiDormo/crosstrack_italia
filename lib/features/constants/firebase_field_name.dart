import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  //still need to a dd all of the field names
  static const userId = 'userId';
  static const displayName = 'displayName';
  static const email = 'email';
  static const createdAt = 'created_at';

  //track info
  static const trackWebCode = 'codice_web';
  static const trackId = 'trackId';
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
  static const openingHours = 'apertura';
  static const latitude = 'latitudine';
  static const longitude = 'longitudine';
  static const images = 'immagini';
  static const photosUrl = 'foto';

  static var profileImageUrl;

  ///TODO remove this profile image variable above

  const FirebaseFieldName._();
}

import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseFieldName {
  //still need to a dd all of the field names
  static const userId = 'userId';
  static const displayName = 'displayName';
  static const email = 'email';
  static const createdAt = 'created_at';
  static const trackId = 'trackId';
  static const trackDisplayName = 'trackName';
  static const trackLocation = 'trackLocation';
  static const trackDescription = 'trackDescription';
  static const trackImage = 'trackImage';

  const FirebaseFieldName._();
}

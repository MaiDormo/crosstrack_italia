import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  static const users = 'users';
  static const comments = 'comments';
  static const tracks = 'tracks';
  const FirebaseCollectionName._();
}

import 'package:flutter/foundation.dart' show immutable;

@immutable
class FirebaseCollectionName {
  //still need to add all of the collections
  static const users = 'users';
  static const comments = 'comments';
  static const tracks = 'tracks';
  static const posts = 'posts';
  // static const events = 'events';
  const FirebaseCollectionName._();
}

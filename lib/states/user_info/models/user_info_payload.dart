import 'dart:collection' show MapView;

import 'package:crosstrack_italia/states/constants/firebase_collection_name.dart';
import 'package:crosstrack_italia/states/posts/typedefs/user_id.dart';
import 'package:flutter/foundation.dart' show immutable;

@immutable
class UserInfoPayload extends MapView<String, String> {
  UserInfoPayload({
    required UserId userId,
    required String? displayName,
    required String? email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}

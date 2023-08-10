import 'package:flutter/foundation.dart' show immutable;

//immutable class that contains all the constants
@immutable
class Constants {
  static const accountExistsWithDifferentCredentialsError =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';

  const Constants._();
}

import 'package:flutter/foundation.dart' show immutable;

//immutable class that contains all the constants
@immutable
class Constants {

  const Constants._();
  static const accountExistsWithDifferentCredentialsError =
      'account-exists-with-different-credential';
  static const googleCom = 'google.com';
  static const emailScope = 'email';
  static const facebookProfileScope = 'public_profile';
  static const facebookName = 'name';
  static const facebookEmailScope = 'email';
}

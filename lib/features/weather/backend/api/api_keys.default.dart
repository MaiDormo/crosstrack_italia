import 'package:flutter/foundation.dart' show immutable;

/// To get an API key, sign up here:
/// https://home.openweathermap.org/users/sign_up
///
/// Then paste it in here and rename this file to `api_keys.dart`.
///
/// You can also specify an API Key via --dart-define. Example:
/// "flutter run --dart-define API_KEY=YOUR_API_KEY

@immutable
class APIKeys {
  static const openWeatherAPIKey = 'bdded70173776df44988b2131c50d6bd';
}

import 'package:flutter/foundation.dart' show immutable;

/// API Keys configuration for external services.
///
/// To get an OpenWeatherMap API key, sign up here:
/// https://home.openweathermap.org/users/sign_up
///
/// Then provide the API key via --dart-define at build time:
/// ```bash
/// flutter run --dart-define=OPENWEATHER_API_KEY=your_api_key_here
/// flutter build apk --dart-define=OPENWEATHER_API_KEY=your_api_key_here
/// ```
///
/// For CI/CD, set the OPENWEATHER_API_KEY as a secret environment variable.
@immutable
class APIKeys {
  /// OpenWeatherMap API key loaded from environment variables.
  ///
  /// Returns empty string if not configured - weather features will be disabled.
  static const openWeatherAPIKey = String.fromEnvironment(
    'OPENWEATHER_API_KEY',
    defaultValue: '',
  );

  /// Returns true if the OpenWeatherMap API key is configured.
  static bool get hasOpenWeatherKey => openWeatherAPIKey.isNotEmpty;
}

import '../../backend/api/api_keys.default.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather/weather.dart';

part 'weather_factory_provider.g.dart';

@riverpod
Future<WeatherFactory?> weatherFactory(Ref ref) async {
  // Return null if API key is not configured
  if (!APIKeys.hasOpenWeatherKey) {
    return null;
  }
  
  final wf = WeatherFactory(
    APIKeys.openWeatherAPIKey,
    language: Language.ITALIAN,
  );

  return wf;
}

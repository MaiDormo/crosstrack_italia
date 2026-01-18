import 'package:crosstrack_italia/features/weather/backend/api/api_keys.default.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather/weather.dart';

part 'weather_factory_provider.g.dart';

@riverpod
Future<WeatherFactory> weatherFactory(Ref ref) async {
  final wf = await WeatherFactory(
    APIKeys.openWeatherAPIKey,
    language: Language.ITALIAN,
  );

  return wf;
}

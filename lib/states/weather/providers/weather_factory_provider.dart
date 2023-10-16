import 'package:crosstrack_italia/states/weather/costants/weather_strings.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather/weather.dart';

part 'weather_factory_provider.g.dart';

@riverpod
WeatherFactory weatherFactory(WeatherFactoryRef ref) {
  return WeatherFactory(
    WeatherStrings.apikey,
    language: Language.ITALIAN,
  );
}

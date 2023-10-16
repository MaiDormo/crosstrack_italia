import 'package:crosstrack_italia/states/weather/providers/weather_factory_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather/weather.dart';

part 'weather_info_forecast_provider.g.dart';

@riverpod
Future<List<Weather>> weatherInfoForecast(
    WeatherInfoForecastRef ref, LatLng location) async {
  final wf = ref.watch(weatherFactoryProvider);
  return await wf.fiveDayForecastByLocation(
      location.latitude, location.longitude);
}

import 'package:crosstrack_italia/states/weather/providers/weather_factory_provider.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:weather/weather.dart';

part 'weather_info_current_provider.g.dart';

@riverpod
Future<Weather> weatherInfoCurrent(
  WeatherInfoCurrentRef ref,
  LatLng location,
) async {
  final wf = ref.watch(weatherFactoryProvider);
  return await wf.currentWeatherByLocation(
    location.latitude,
    location.longitude,
  );
}

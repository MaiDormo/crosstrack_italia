import 'package:crosstrack_italia/features/weather/domain/models/forecast.dart';
import 'package:crosstrack_italia/features/weather/domain/providers/weather_factory_provider.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forecast_info_provider.g.dart';

@riverpod
Future<Forecast> forecastInfo(ForecastInfoRef ref) async {
  const defaultValue = 0.0;
  late final forecast;
  final wf = await ref.watch(weatherFactoryProvider.future);
  final coordinatesTrackSelected = ref.watch(trackSelectedProvider
      .select((track) => (track?.longitude, track?.latitude)));
  try {
    forecast = await wf.fiveDayForecastByLocation(
      coordinatesTrackSelected.$1 ?? defaultValue,
      coordinatesTrackSelected.$2 ?? defaultValue,
    );
  } on Exception catch (e) {
    ///TODO: remove print and handle error
    print(e);

    return Forecast.fromAPI([]);
  }
  return Forecast.fromAPI(forecast);
}

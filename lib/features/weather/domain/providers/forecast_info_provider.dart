import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/weather/domain/models/forecast.dart';
import 'package:crosstrack_italia/features/weather/domain/providers/weather_factory_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forecast_info_provider.g.dart';

@riverpod
Future<Forecast> forecastInfo(ForecastInfoRef ref) async {
  late final forecast;
  final wf = await ref.watch(weatherFactoryProvider.future);
  final coordinatesTrackSelected = ref.watch(
    trackSelectedProvider.select(
      (track) => (
        double.parse(track.longitude),
        double.parse(track.latitude),
      ),
    ),
  );
  try {
    forecast = await wf.fiveDayForecastByLocation(
      coordinatesTrackSelected.$1,
      coordinatesTrackSelected.$2,
    );
  } on Exception {
    return Forecast.fromAPI([]);
  }
  return Forecast.fromAPI(forecast);
}

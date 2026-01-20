import '../../../track/notifiers/track_notifier.dart';
import '../models/forecast.dart';
import 'weather_factory_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forecast_info_provider.g.dart';

@riverpod
Future<Forecast?> forecastInfo(Ref ref) async {
  final wf = await ref.watch(weatherFactoryProvider.future);
  
  // Return null if weather API is not configured
  if (wf == null) {
    return null;
  }
  
  final trackSelected = ref.watch(trackSelectedProvider);
  final coordinatesTrackSelected = (
    double.parse(trackSelected.longitude),
    double.parse(trackSelected.latitude),
  );
  
  try {
    final forecast = await wf.fiveDayForecastByLocation(
      coordinatesTrackSelected.$1,
      coordinatesTrackSelected.$2,
    );
    return Forecast.fromAPI(forecast);
  } on Exception catch (e) {
    // Log error but return empty forecast instead of crashing
    print('Weather API error: $e');
    return Forecast.fromAPI([]);
  }
}

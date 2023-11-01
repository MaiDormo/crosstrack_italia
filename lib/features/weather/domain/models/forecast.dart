import 'package:crosstrack_italia/features/weather/domain/models/weather_info.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather/weather.dart';

part 'forecast.freezed.dart';

@freezed
class Forecast with _$Forecast {
  factory Forecast({
    required List<WeatherInfo> list,
  }) = _Forecast;

  factory Forecast.fromAPI(List<Weather> weatherList) {
    return Forecast(
      list: weatherList.map((weather) => WeatherInfo.fromAPI(weather)).toList(),
    );
  }
}

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
    if (weatherList.isEmpty) {
      return Forecast(list: []);
    }

    int days = 5;
    int intervalsPerDay = 8; // 24 hours / 3 hours per interval

    return Forecast(
      list: List.generate(days, (i) => i * intervalsPerDay)
          .map((index) => WeatherInfo.fromAPI(weatherList[index]))
          .toList(),
    );
  }
}

import 'package:weather/weather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_info.freezed.dart';

@freezed
class WeatherInfo with _$WeatherInfo {
  factory WeatherInfo({
    required String date,
    required String iconUrl,
    required String temperature,
    required String weatherCondition,
  }) = _WeatherInfo;

  factory WeatherInfo.fromAPI(Weather weather) => WeatherInfo(
        date:
            weather.date!.day.toString() + '/' + weather.date!.month.toString(),
        iconUrl: weather.weatherIcon!,
        temperature: weather.temperature!.celsius!.floor().toString() + '°C',
        weatherCondition: weather.weatherMain!,
      );
}

// class WeatherInfo {
//   final String date;
//   final String hour;
//   final String iconUrl;
//   final String temperature;

//   WeatherInfo({
//     required this.date,
//     required this.hour,
//     required this.iconUrl,
//     required this.temperature,
//   });

//   factory WeatherInfo.from(Weather weather) {
//     return WeatherInfo(
//       date: weather.date!.day.toString() + '/' + weather.date!.month.toString(),
//       hour:
//           weather.date!.hour.toString() + ':' + weather.date!.minute.toString(),
//       iconUrl: weather.weatherIcon!,
//       temperature: weather.temperature!.celsius!.floor().toString() + '°C',
//     );
//   }
// }

import 'package:crosstrack_italia/states/weather/providers/weather_info_forecast_provider.dart';
import 'package:crosstrack_italia/views/components/animations/error_animation_view.dart';
import 'package:crosstrack_italia/views/components/tracks/panel_widget.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather/weather.dart';

// LatLng(double.parse(trackSelected!.location.split(',')[0]), double.parse(trackSelected.location.split(',')[1]),)

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final coordinatesTrackSelected =
        ref.watch(trackSelectedProvider.select((track) => track?.coordinates));
    late final fivedayforecast = ref.watch(
        weatherInfoForecastProvider(coordinatesTrackSelected ?? LatLng(0, 0)));

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Text('Meteo:',
              style: TextStyle(
                fontSize: 16 * height_unit,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              )),
          fivedayforecast.when(
            data: (List<Weather> weather) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              mainAxisSize: MainAxisSize.max,
              children: [
                for (var i = 0; i < weather.length; i += 8)
                  Expanded(
                    child: Card(
                      color: Colors.lightBlue[100],
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${weather[i].date!.day.toString()}/${weather[i].date!.month.toString()}',
                            style: TextStyle(
                              fontSize: 16 * height_unit,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          //hour
                          Text(
                            '${weather[i].date!.hour.toString()}:${weather[i].date!.minute.toString()}',
                            style: TextStyle(
                              fontSize: 16 * height_unit,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                            'https://openweathermap.org/img/wn/${weather[i].weatherIcon}.png',
                            height: 50 * height_unit,
                            width: 50 * height_unit,
                          ),
                          Text(
                            '${weather[i].temperature!.celsius?.floor().toString()}°C',
                            style: TextStyle(
                              fontSize: 16 * height_unit,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            error: (error, stackTrace) => const ErrorAnimationView(),
            loading: () => const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

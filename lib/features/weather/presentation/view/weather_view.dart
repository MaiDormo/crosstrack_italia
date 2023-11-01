import 'package:crosstrack_italia/features/weather/domain/models/forecast.dart';
import 'package:crosstrack_italia/features/weather/domain/providers/forecast_info_provider.dart';
import 'package:crosstrack_italia/views/components/animations/error_animation_view.dart';
import 'package:crosstrack_italia/views/components/tracks/panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Text(
            'Meteo:',
            style: TextStyle(
              fontSize: 16 * height_unit,
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          Consumer(
            builder: (context, ref, child) {
              final AsyncValue<Forecast> forecastInfo =
                  ref.watch(forecastInfoProvider);
              return SafeArea(
                child: Center(
                  child: switch (forecastInfo) {
                    AsyncData(:final value) => WeatherWidget(forecast: value),
                    AsyncError() => const ErrorAnimationView(),
                    _ => const CircularProgressIndicator(),
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class WeatherWidget extends StatelessWidget {
  final Forecast forecast;
  const WeatherWidget({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        for (var i = 0; i < forecast.list.length; i += 8)
          Expanded(
            child: Card(
              color: Colors.lightBlue[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    forecast.list[i].date,
                    style: TextStyle(
                      fontSize: 16 * height_unit,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //hour
                  Text(
                    forecast.list[i].hour,
                    style: TextStyle(
                      fontSize: 16 * height_unit,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Image.network(
                    'https://openweathermap.org/img/wn/${forecast.list[i].iconUrl}.png',
                    height: 50 * height_unit,
                    width: 50 * height_unit,
                  ),
                  Text(
                    forecast.list[i].temperature,
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
    );
  }
}

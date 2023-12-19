import 'package:crosstrack_italia/features/map/providers/panel_style.dart';
import 'package:crosstrack_italia/features/weather/domain/models/forecast.dart';
import 'package:crosstrack_italia/features/weather/domain/providers/forecast_info_provider.dart';
import 'package:crosstrack_italia/views/components/animations/error_animation_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heightFactor = ref.read(heightFactorProvider(context));
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Text(
            'Meteo:',
            style: TextStyle(
              fontSize: 16 * heightFactor,
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

class WeatherWidget extends ConsumerWidget {
  final Forecast forecast;
  const WeatherWidget({
    super.key,
    required this.forecast,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final heightFactor = ref.read(heightFactorProvider(context));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        ...forecast.list.map(
          (weather) => Expanded(
            child: Card(
              color: Colors.lightBlue[100],
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    weather.date,
                    style: TextStyle(
                      fontSize: 16 * heightFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  //hour
                  Image.network(
                    'https://openweathermap.org/img/wn/${weather.iconUrl}.png',
                    height: 50 * heightFactor,
                    width: 50 * heightFactor,
                  ),
                  Text(
                    weather.temperature,
                    style: TextStyle(
                      fontSize: 16 * heightFactor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:crosstrack_italia/features/weather/domain/models/forecast.dart';
import 'package:crosstrack_italia/features/weather/domain/providers/forecast_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      children: [
        Text(
          'Meteo:',
          style: TextStyle(
            fontSize: 12.sp,
            color: Theme.of(context).colorScheme.tertiary,
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
                  AsyncError() => const Icon(Icons.error),
                  _ => const CircularProgressIndicator(),
                },
              ),
            );
          },
        ),
      ],
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: [
        ...forecast.list.map(
          (weather) => Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  weather.date,
                  style: TextStyle(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //hour
                Image.network(
                  'https://openweathermap.org/img/wn/${weather.iconUrl}.png',
                  height: 37.5.h,
                  width: 37.5.w,
                ),
                Text(
                  weather.temperature,
                  style: TextStyle(
                    fontSize: 12.sp,
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

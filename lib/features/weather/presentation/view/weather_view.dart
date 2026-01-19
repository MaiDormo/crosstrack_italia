import 'package:crosstrack_italia/features/weather/domain/models/forecast.dart';
import 'package:crosstrack_italia/features/weather/domain/providers/forecast_info_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class WeatherView extends ConsumerWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final colorScheme = Theme.of(context).colorScheme;
    
    return Column(
      children: [
        Text(
          'Meteo:',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: colorScheme.onSurface.withValues(alpha: 0.6),
            fontWeight: FontWeight.w600,
          ),
        ),
        8.verticalSpace,
        Consumer(
          builder: (context, ref, child) {
            final AsyncValue<Forecast?> forecastInfo =
                ref.watch(forecastInfoProvider);
            return Center(
              child: switch (forecastInfo) {
                AsyncData(:final value) => value == null
                    ? _buildNotConfigured(context, colorScheme)
                    : value.list.isEmpty
                        ? _buildNoData(context, colorScheme)
                        : WeatherWidget(forecast: value),
                AsyncError(:final error) => _buildError(context, colorScheme, error),
                _ => SizedBox(
                    height: 60.h,
                    child: Center(
                      child: SizedBox(
                        width: 24.r,
                        height: 24.r,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: colorScheme.primary,
                        ),
                      ),
                    ),
                  ),
              },
            );
          },
        ),
      ],
    );
  }

  Widget _buildNotConfigured(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_off_rounded,
            size: 20.r,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          8.horizontalSpace,
          Text(
            'Meteo non disponibile',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoData(BuildContext context, ColorScheme colorScheme) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.cloud_outlined,
            size: 20.r,
            color: colorScheme.onSurface.withValues(alpha: 0.5),
          ),
          8.horizontalSpace,
          Text(
            'Dati meteo non disponibili',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: colorScheme.onSurface.withValues(alpha: 0.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError(BuildContext context, ColorScheme colorScheme, Object error) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: colorScheme.error.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            size: 20.r,
            color: colorScheme.error,
          ),
          8.horizontalSpace,
          Text(
            'Errore meteo',
            style: GoogleFonts.poppins(
              fontSize: 12.sp,
              color: colorScheme.error,
            ),
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
    final colorScheme = Theme.of(context).colorScheme;
    
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          ...forecast.list.map(
            (weather) => Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 4.w),
                padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 4.w),
                decoration: BoxDecoration(
                  color: colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      weather.date,
                      style: GoogleFonts.poppins(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                    Image.network(
                      'https://openweathermap.org/img/wn/${weather.iconUrl}.png',
                      height: 32.h,
                      width: 32.w,
                      errorBuilder: (context, error, stackTrace) => Icon(
                        Icons.cloud_outlined,
                        size: 32.r,
                        color: colorScheme.onSurface.withValues(alpha: 0.3),
                      ),
                    ),
                    Text(
                      weather.temperature,
                      style: GoogleFonts.poppins(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

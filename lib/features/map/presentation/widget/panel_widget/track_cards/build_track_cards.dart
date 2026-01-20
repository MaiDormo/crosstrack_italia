import 'cards/build_swiper.dart';
import 'cards/build_motoclub_card.dart';
import 'cards/build_pilot_info_card.dart';
import 'cards/build_services_card.dart';
import 'cards/build_track_info_card.dart';
import '../../../../../track/models/track.dart';
import '../../../../../track/presentation/comment_section.dart';
import '../../../../../weather/presentation/view/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

Widget buildTrackCards(
  Track trackSelected,
  AsyncValue<Iterable<Widget>> allTrackImages,
  BuildContext context,
) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    mainAxisSize: MainAxisSize.min,
    children: [
      // First row: Motoclub + Track Info
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildMotoclubCard(trackSelected, context),
          SizedBox(width: 10.w.clamp(6.0, 12.0)),
          buildTrackInfoCard(trackSelected, context),
        ],
      ),
      SizedBox(height: 10.h),
      // Second row: Pilot Info + Services
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildPilotInfoCard(trackSelected, context),
          SizedBox(width: 10.w.clamp(6.0, 12.0)),
          buildServicesCard(trackSelected, context),
        ],
      ),
      SizedBox(height: 14.h),
      // Image swiper
      buildTrackImagesSwiper(allTrackImages, context),
      SizedBox(height: 14.h),
      // Weather section
      _buildSectionCard(
        context,
        'Meteo',
        Icons.wb_sunny_rounded,
        const WeatherView(),
      ),
      SizedBox(height: 10.h),
      // Comments section
      _buildSectionCard(
        context,
        'Recensioni',
        Icons.chat_bubble_outline_rounded,
        CommentsSection(trackId: trackSelected.id),
      ),
    ],
  );
}

Widget _buildSectionCard(
  BuildContext context,
  String title,
  IconData icon,
  Widget child,
) {
  final colorScheme = Theme.of(context).colorScheme;

  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.all(14.r.clamp(10.0, 16.0)),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(6.r.clamp(5.0, 8.0)),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 16.r.clamp(14.0, 18.0),
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 8.w.clamp(6.0, 10.0)),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 13.sp.clamp(12.0, 14.0),
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
        child,
      ],
    ),
  );
}

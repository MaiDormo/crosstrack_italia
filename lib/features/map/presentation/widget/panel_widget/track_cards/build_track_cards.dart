import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_swiper.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_motoclub_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_pilot_info_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_services_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_track_info_card.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/presentation/comment_section.dart';
import 'package:crosstrack_italia/features/weather/presentation/view/weather_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

Widget buildTrackCards(
  Track trackSelected,
  AsyncValue<Iterable<Widget>> allTrackImages,
  BuildContext context,
) =>
    Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.min,
      children: [
        // First row: Motoclub + Track Info
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildMotoclubCard(trackSelected, context),
            SizedBox(width: 12.w),
            buildTrackInfoCard(trackSelected, context),
          ],
        ),
        SizedBox(height: 12.h),
        // Second row: Pilot Info + Services
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildPilotInfoCard(trackSelected, context),
            SizedBox(width: 12.w),
            buildServicesCard(trackSelected, context),
          ],
        ),
        SizedBox(height: 16.h),
        // Image swiper
        buildTrackImagesSwiper(allTrackImages, context),
        SizedBox(height: 16.h),
        // Weather section
        _buildSectionCard(
          context,
          'Meteo',
          Icons.wb_sunny_rounded,
          const WeatherView(),
        ),
        SizedBox(height: 12.h),
        // Comments section
        _buildSectionCard(
          context,
          'Recensioni',
          Icons.chat_bubble_outline_rounded,
          CommentsSection(trackId: trackSelected.id),
        ),
      ],
    );

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
          padding: EdgeInsets.all(16.r),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(8.r),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
              ),
              SizedBox(width: 10.w),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: colorScheme.onSurface,
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

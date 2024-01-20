import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_swiper.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_motoclub_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_pilot_info_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_services_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_track_info_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
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
    SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRow([
            buildMotoclubCard(trackSelected, context),
            buildTrackInfoCard(trackSelected, context),
          ]),
          9.verticalSpace,
          buildRow([
            buildPilotInfoCard(trackSelected, context),
            buildServicesCard(trackSelected, context),
          ]),
          9.verticalSpace,
          buildTrackImagesSwiper(allTrackImages, context),
          9.verticalSpace,
          buildCard(
            WeatherView(),
            context,
          ),
          9.verticalSpace,
          buildCard(
            CommentsSection(trackId: trackSelected.id),
            context,
          ),
        ],
      ),
    );

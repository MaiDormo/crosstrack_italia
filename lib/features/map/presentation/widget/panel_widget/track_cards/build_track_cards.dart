import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_motoclub_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_pilot_info_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_services_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/track_cards/cards/build_track_info_card.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/presentation/comment_section.dart';
import 'package:crosstrack_italia/features/weather/presentation/view/weather_view.dart';
import 'package:flutter/material.dart';

Widget buildTrackCards(
        Track trackSelected, BuildContext context, double heightFactor) =>
    SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.min,
        children: [
          buildRow([
            buildMotoclubCard(trackSelected, context, heightFactor),
            buildTrackInfoCard(trackSelected, context, heightFactor),
          ]),
          SizedBox(height: 12 * heightFactor),
          buildRow([
            buildPilotInfoCard(trackSelected, context, heightFactor),
            buildServicesCard(trackSelected, context, heightFactor),
          ]),
          SizedBox(height: 12 * heightFactor),
          buildCard(WeatherView()),
          SizedBox(height: 12 * heightFactor),
          buildCard(CommentsSection(trackId: trackSelected.id)),
        ],
      ),
    );

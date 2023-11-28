import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';

Widget buildTrackName(
        Track trackSelected, BuildContext context, double heightFactor) =>
    buildStyledText(
      trackSelected.trackName,
      20 * heightFactor,
      FontWeight.bold,
      Theme.of(context).colorScheme.primary,
    );

Widget buildTrackLocation(Track trackSelected, double heightFactor) =>
    buildStyledText(
      trackSelected.location,
      14 * heightFactor,
      FontWeight.bold,
      Colors.grey,
    );

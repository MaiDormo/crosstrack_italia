import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackName(
  Track trackSelected,
  BuildContext context,
) =>
    buildStyledText(
      trackSelected.trackName,
      15.sp,
      FontWeight.bold,
      Theme.of(context).colorScheme.primary,
    );

Widget buildTrackLocation(
  Track trackSelected,
) =>
    buildStyledText(
      trackSelected.location,
      10.5.sp,
      FontWeight.bold,
      Colors.grey,
    );

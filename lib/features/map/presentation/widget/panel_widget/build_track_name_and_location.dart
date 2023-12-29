import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackName(
  Track trackSelected,
  BuildContext context,
) =>
    buildStyledText(
      text: trackSelected.trackName,
      fontSize: 15.sp,
      fontWeight: FontWeight.bold,
    );

Widget buildTrackLocation(
  Track trackSelected,
) =>
    buildStyledText(
      text: trackSelected.location,
      fontSize: 10.5.sp,
      fontWeight: FontWeight.bold,
      color: Colors.grey,
    );

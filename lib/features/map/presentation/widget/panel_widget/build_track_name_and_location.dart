import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackName(Track trackSelected, BuildContext context) {
  return Text(
    trackSelected.trackName,
    style: TextStyle(
      fontSize: 20.sp.clamp(18.0, 22.0),
      fontWeight: FontWeight.w700,
      color: Theme.of(context).colorScheme.onSurface,
      letterSpacing: -0.5,
    ),
    maxLines: 2,
    overflow: TextOverflow.ellipsis,
  );
}

Widget buildTrackLocation(Track trackSelected) {
  return Builder(
    builder: (context) {
      return Row(
        children: [
          Icon(
            Icons.location_on_outlined,
            size: 14.r.clamp(12.0, 16.0),
            color: Theme.of(context).colorScheme.tertiary,
          ),
          const SizedBox(width: 4),
          Flexible(
            child: Text(
              trackSelected.location,
              style: TextStyle(
                fontSize: 13.sp.clamp(12.0, 14.0),
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.tertiary,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      );
    },
  );
}

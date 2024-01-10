import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackMarkerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MapConstans.markerSize.h,
      width: MapConstans.markerSize.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor, // Set border color
          width: 3.0.w, // Set border width
        ),
        borderRadius: BorderRadius.circular(MapConstans.markerSize.h),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MapConstans.markerSize.h),
        child: Image.asset(
          MapConstans
              .placeholder, // Replace with the path to your Motocross track icon
          width: 20.w,
          height: 20.h,
        ),
      ),
    );
  }
}

import '../../../constants/map_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackMarkerIcon extends StatelessWidget {
  const TrackMarkerIcon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MapConstants.markerSize.h,
      width: MapConstants.markerSize.h,
      decoration: BoxDecoration(
        border: Border.all(
          color: Theme.of(context).primaryColor, // Set border color
          width: 3.0.w, // Set border width
        ),
        borderRadius: BorderRadius.circular(MapConstants.markerSize.h),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MapConstants.markerSize.h),
        child: Image.asset(
          MapConstants
              .placeholder, // Replace with the path to your Motocross track icon
          width: 20.w,
          height: 20.h,
        ),
      ),
    );
  }
}

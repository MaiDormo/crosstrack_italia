import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:flutter/material.dart';

class TrackMarkerIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MapConstans.markerSize,
      width: MapConstans.markerSize,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orange, // Set border color
          width: 3.0, // Set border width
        ),
        borderRadius: BorderRadius.circular(MapConstans.markerSize),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MapConstans.markerSize),
        child: Image.asset(
          MapConstans
              .placeholder, // Replace with the path to your Motocross track icon
          width: 40.0 * MapConstans.scaleImage,
          height: 40.0 * MapConstans.scaleImage,
        ),
      ),
    );
  }
}

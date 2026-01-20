import '../../../constants/map_constants.dart';
import 'track_marker_icon.dart';
import '../../../../track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class TrackMarker extends Marker {
  TrackMarker({required this.track})
      : super(
          alignment: Alignment.topCenter,
          height: MapConstants.markerSize.h,
          width: MapConstants.markerSize.h,
          point: LatLng(
              double.parse(track.latitude), double.parse(track.longitude)),
          child: TrackMarkerIcon(),
        );

  final Track track;
}

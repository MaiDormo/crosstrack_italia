import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/track_marker_icon.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';

class TrackMarker extends Marker {
  TrackMarker({required this.track})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: MapConstans.markerSize.h,
          width: MapConstans.markerSize.h,
          point: LatLng(
              double.parse(track.latitude), double.parse(track.longitude)),
          builder: (BuildContext ctx) => TrackMarkerIcon(),
        );

  final Track track;
}

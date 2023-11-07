import 'package:crosstrack_italia/features/map/providers/constants/constants.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class TrackMarker extends Marker {
  TrackMarker({required this.track})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: markerSize,
          width: markerSize,
          point: LatLng(
              double.parse(track.latitude), double.parse(track.longitude)),
          builder: (BuildContext ctx) => const Icon(Icons.sports_score),
        );

  final Track track;
}
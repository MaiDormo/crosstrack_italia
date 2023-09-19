import 'package:crosstrack_italia/states/map/providers/constants/constants.dart';
import 'package:crosstrack_italia/states/track_info/models/track_info_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';

class TrackMarker extends Marker {
  TrackMarker({required this.track})
      : super(
          anchorPos: AnchorPos.align(AnchorAlign.top),
          height: markerSize,
          width: markerSize,
          point: track.coordinates,
          builder: (BuildContext ctx) => const Icon(Icons.sports_score),
        );

  final TrackInfoModel track;
}

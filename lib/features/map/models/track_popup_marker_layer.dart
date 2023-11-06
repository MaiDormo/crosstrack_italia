import 'package:crosstrack_italia/features/map/models/track_marker.dart';
import 'package:crosstrack_italia/features/map/models/track_marker_popup.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TrackPopupMarkerLayer extends StatelessWidget {
  const TrackPopupMarkerLayer({
    super.key,
    required this.tracks,
  });

  final Iterable<Track> tracks;

  @override
  Widget build(BuildContext context) {
    return PopupMarkerLayer(
      options: PopupMarkerLayerOptions(
        markers: tracks
            .map(
              (track) => TrackMarker(
                track: track,
              ),
            )
            .toList(),
        popupController: PopupController(),
        popupDisplayOptions: PopupDisplayOptions(
          builder: (_, Marker marker) {
            if (marker is TrackMarker) {
              return TrackMarkerPopup(track: marker.track);
            }
            return const Card(child: Text('Not a Track'));
          },
          animation: PopupAnimation.fade(),
        ),
      ),
    );
  }
}

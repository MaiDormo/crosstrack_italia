import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/track_marker.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/track_marker_popup.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
            } else {
              return const SizedBox();
            }
          },
          animation: PopupAnimation.fade(),
        ),
        markerCenterAnimation: MarkerCenterAnimation(
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        ),
        markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
        selectedMarkerBuilder: (context, marker) => Container(
          height: MapConstans.markerSize.h,
          width: MapConstans.markerSize.h,
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: Colors.orange, // Set border color
              width: 3.0.w, // Set border width
            ),
            borderRadius: BorderRadius.circular(MapConstans.markerSize.h),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(MapConstans.markerSize.h),
            child: Icon(
              Icons.exit_to_app_rounded,
              size: 30.0.h,
              color: Colors.orange,
            ),
          ),
        ),
      ),
    );
  }
}

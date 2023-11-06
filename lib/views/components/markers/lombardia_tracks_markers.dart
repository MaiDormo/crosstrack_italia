import 'package:crosstrack_italia/features/map/models/track_popup_marker_layer.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LombardiaTracksMarkers extends ConsumerWidget {
  const LombardiaTracksMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(fetchTracksByRegionProvider('Lombardia'));
    return tracks.when(
      data: (tracks) {
        return tracks.isNotEmpty
            ? TrackPopupMarkerLayer(tracks: tracks)
            : const MarkerLayer();
      },
      error: (error, stackTrace) => const MarkerLayer(),
      loading: () => const MarkerLayer(),
    );
  }
}

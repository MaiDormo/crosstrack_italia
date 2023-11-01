import 'package:crosstrack_italia/features/map/models/track_popup_marker_layer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../features/track_info/providers/all_track_info_provider.dart';

class AllTracksMarkers extends ConsumerWidget {
  const AllTracksMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(allTrackInfoProvider);
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

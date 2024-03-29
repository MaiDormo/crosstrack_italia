import 'package:crosstrack_italia/features/map/presentation/widget/marker/track_popup_marker_layer.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllTracksMarkers extends ConsumerWidget {
  const AllTracksMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(fetchAllTracksProvider);
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

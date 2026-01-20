import 'track_popup_marker_layer.dart';
import '../../../../track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrentinoAltoAdigeTracksMarkers extends ConsumerWidget {
  const TrentinoAltoAdigeTracksMarkers({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks =
        ref.watch(fetchTracksByRegionProvider('Trentino Alto Adige'));
    return tracks.when(
      data: (tracks) {
        return tracks.isNotEmpty
            ? TrackPopupMarkerLayer(tracks: tracks)
            : const MarkerLayer(markers: []);
      },
      error: (error, stackTrace) => const MarkerLayer(markers: []),
      loading: () => const MarkerLayer(markers: []),
    );
  }
}

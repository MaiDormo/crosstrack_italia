import 'package:crosstrack_italia/states/track_info/providers/veneto_tracks_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class VenetoTracksMarkers extends ConsumerWidget {
  const VenetoTracksMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(venetoTracksProvider);
    return tracks.when(
      data: (tracks) {
        return tracks.isNotEmpty
            ? MarkerLayer(
                markers: tracks
                    .map(
                      (track) => Marker(
                        width: 40,
                        height: 40,
                        point: track.coordinates,
                        builder: (context) => const Icon(
                          Icons.sports_score,
                          size: 40,
                          color: Colors.red,
                        ),
                      ),
                    )
                    .toList(),
              )
            : const MarkerLayer();
      },
      error: (error, stackTrace) => const MarkerLayer(),
      loading: () => const MarkerLayer(),
    );
  }
}

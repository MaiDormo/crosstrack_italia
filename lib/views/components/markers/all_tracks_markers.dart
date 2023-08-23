import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../states/track_info/providers/all_track_info_provider.dart';

class AllTracksMarkers extends ConsumerWidget {
  const AllTracksMarkers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(allTrackInfoProvider);
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
                          color: Colors.orangeAccent,
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

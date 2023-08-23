import 'package:crosstrack_italia/states/track_info/models/track_info_model.dart';
import 'package:flutter/material.dart';

///TODO: improve the design of this widget

class TracksListView extends StatelessWidget {
  final Iterable<TrackInfoModel> tracks;

  const TracksListView({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return Column(
      //create a map function that returns every track as a TrackCard
      children: tracks
          .map(
            (track) => TrackCard(track: track),
          )
          .toList(),
    );
  }
}

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.track,
  });

  final TrackInfoModel track;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              track.location,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.pin_drop,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Flexible(
                  // Wrap in Flexible to handle long text
                  child: Text(
                    track.region,
                    overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Spacer(),
                Flexible(
                  // Wrap in Flexible to handle long text
                  child: Text(
                    track.motoclub,
                    overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(
                  Icons.sports_score,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 4),
                Text(
                  track.category ?? 'no category',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

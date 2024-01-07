import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/presentation/track_card.dart';
import 'package:flutter/material.dart';

class TracksListView extends StatelessWidget {
  final Iterable<Track> tracks;

  const TracksListView({super.key, required this.tracks});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tracks.length,
      itemBuilder: (context, index) {
        return TrackCard(track: tracks.elementAt(index));
      },
    );
  }
}

import 'package:flutter/material.dart';

import '../models/track.dart';
import 'track_card.dart';

class TracksListView extends StatelessWidget {

  const TracksListView({super.key, required this.tracks});
  
  final Iterable<Track> tracks;

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

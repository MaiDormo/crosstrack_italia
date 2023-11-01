import 'package:crosstrack_italia/features/track_info/models/track_info_model.dart';
import 'package:crosstrack_italia/views/components/tracks/track_card.dart';
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

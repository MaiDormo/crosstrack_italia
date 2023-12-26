import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen.dart';
import 'package:crosstrack_italia/features/user_info/providers/owned_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OwnedTracksScreen extends ConsumerWidget {
  const OwnedTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownedTrackState = ref.watch(ownedTracksNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tracciati Posseduti'),
        ),
        body: ownedTrackState.when(
          data: (tracks) => ref
              .watch(fetchTracksByIdsProvider(tracks, context))
              .when(
                data: (tracksList) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: tracksList.length,
                    itemBuilder: (context, index) {
                      final track = tracksList.elementAt(index);
                      return GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditTrackScreen(
                                track: track,
                              ),
                            ),
                          );
                        },
                        child: Card(
                          margin: const EdgeInsets.symmetric(vertical: 4.0),
                          child: ListTile(
                            title: Material(
                              type: MaterialType
                                  .transparency, // makes the child widget transparent
                              child: Text(
                                track.trackName,
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            subtitle: Text(
                              track.region,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                ref
                                    .read(ownedTracksNotifierProvider.notifier)
                                    .removeTrack(track.id);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        '${track.trackName} rimosso dai tuoi posseduti'),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/providers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteTracksScreen extends ConsumerWidget {
  const FavoriteTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTrackState = ref.watch(favoriteTracksNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Tracciati Favoriti'),
        ),
        body: favoriteTrackState.when(
          data: (tracks) => ref
              .watch(fetchTracksByIdsProvider(tracks, context))
              .when(
                data: (tracksList) => Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: ListView.builder(
                    itemCount: tracksList.length,
                    itemBuilder: (context, index) {
                      final track = tracksList.elementAt(index);
                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 4.0).h,
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
                                  .read(favoriteTracksNotifierProvider.notifier)
                                  .removeTrack(track.id);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      '${track.trackName} rimosso dai tuoi preferiti'),
                                ),
                              );
                            },
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
                  child: Text(error.toString()),
                ),
              ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
        ),
      ),
    );
  }
}

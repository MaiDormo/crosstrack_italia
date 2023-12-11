import 'package:crosstrack_italia/features/user_info/providers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class FavoriteTracksScreen extends ConsumerWidget {
  const FavoriteTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTrackState = ref.watch(favoriteTracksNotifierProvider);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Favorite Tracks'),
        ),
        body: favoriteTrackState.when(
          data: (tracks) => ListView.builder(
            itemCount: tracks.length,
            itemBuilder: (context, index) {
              final track = tracks[index];
              return ListTile(
                title: Text(track),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    ref
                        .read(favoriteTracksNotifierProvider.notifier)
                        .removeTrack(track);
                  },
                ),
              );
            },
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

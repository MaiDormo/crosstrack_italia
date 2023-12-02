import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/providers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

///TODO add the ability to store the favorite tracks in firebase

class FavoriteTracksScreen extends ConsumerWidget {
  const FavoriteTracksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _favoriteTracks = ref.watch(fetchTracksByIdsProvider);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Scaffold(
            body: switch (_favoriteTracks) {
          AsyncError(:final error) =>
            Text("Errore nel caricamento dei tracciati" + error.toString()),
          AsyncData(:final value) => ListView.builder(
              itemCount: value.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(value.elementAt(index).trackName),
                  subtitle: Text(value.elementAt(index).region),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.favorite,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      ref
                          .read(favoriteTracksNotifierProvider.notifier)
                          .removeFavorite(value.elementAt(index).id);
                    },
                  ),
                );
              },
            ),
          _ => const Center(child: CircularProgressIndicator()),
        }),
      ),
    );
  }
}

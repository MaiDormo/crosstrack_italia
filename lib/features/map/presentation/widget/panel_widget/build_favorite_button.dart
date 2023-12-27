import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/user_info/providers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeartIcon extends ConsumerWidget {
  final String trackId;

  HeartIcon({required this.trackId});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final favoriteTracksNotifier = ref.watch(favoriteTracksNotifierProvider);
    final isFavorite = switch (favoriteTracksNotifier) {
      AsyncData(:final value) => value.contains(trackId),
      _ => false,
    };

    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        if (isFavorite) {
          ref
              .read(favoriteTracksNotifierProvider.notifier)
              .removeTrack(trackId);
        } else {
          ref.read(favoriteTracksNotifierProvider.notifier).addTrack(trackId);
        }
      },
    );
  }
}

Widget buildFavoriteButton(
  Track trackSelected,
  BuildContext context,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        HeartIcon(trackId: trackSelected.id),
      ],
    );

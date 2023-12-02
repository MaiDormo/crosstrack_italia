import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/user_info/providers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeartIcon extends ConsumerWidget {
  final String trackId;

  HeartIcon({required this.trackId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isFavorite =
        ref.watch(favoriteTracksNotifierProvider).contains(trackId);
    return IconButton(
      icon: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onPressed: () {
        final favoriteTracksNotifier =
            ref.read(favoriteTracksNotifierProvider.notifier);
        if (isFavorite) {
          favoriteTracksNotifier.removeFavorite(trackId);
        } else {
          favoriteTracksNotifier.addFavorite(trackId);
        }
      },
    );
  }
}

Widget buildFavoriteButton(
  Track trackSelected,
  BuildContext context,
  double heightFactor,
) =>
    Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        HeartIcon(trackId: trackSelected.id),
      ],
    );

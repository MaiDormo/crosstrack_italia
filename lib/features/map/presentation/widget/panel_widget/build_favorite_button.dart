import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/user_info/constants/user_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_settings.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final showMoreInfo =
        ref.watch(userSettingsProvider)[UserConstants.showMoreInfo]!;

    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.pressed)) {
            return Theme.of(context).colorScheme.onSecondary.withOpacity(0.5);
          }
          return Theme.of(context).colorScheme.onSecondary;
        }),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical: 4.h, // Use ScreenUtil to set height
            horizontal: 5.w, // Use ScreenUtil to set width
          ),
        ),
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Visibility(
            visible: showMoreInfo,
            child: Text(
              isFavorite ? 'Rimuovi dai preferiti' : 'Aggiungi ai preferiti',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 11.25.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Icon(
            isFavorite ? Icons.favorite : Icons.favorite_border,
            color: isFavorite ? Colors.red : Theme.of(context).primaryColor,
          ),
        ],
      ),
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

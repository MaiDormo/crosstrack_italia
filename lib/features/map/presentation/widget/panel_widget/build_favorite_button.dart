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

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: GestureDetector(
        child: Card(
          color: Theme.of(context).colorScheme.onSecondary,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Visibility(
                visible: showMoreInfo,
                child: Padding(
                  padding: const EdgeInsets.all(8.0).h,
                  child: Text(
                    isFavorite
                        ? 'Rimuovi dai preferiti'
                        : 'Aggiungi ai preferiti',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                      fontSize: 11.25.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
        onTap: () {
          if (isFavorite) {
            ref
                .read(favoriteTracksNotifierProvider.notifier)
                .removeTrack(trackId);
          } else {
            ref.read(favoriteTracksNotifierProvider.notifier).addTrack(trackId);
          }
        },
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

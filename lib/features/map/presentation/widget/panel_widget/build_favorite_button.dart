import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class HeartIcon extends ConsumerWidget {
  final String trackId;

  const HeartIcon({super.key, required this.trackId});

  @override
  Widget build(
    BuildContext context,
    WidgetRef ref,
  ) {
    final favoriteTracksNotifier = ref.watch(favoriteTracksProvider);
    final isFavorite = switch (favoriteTracksNotifier) {
      AsyncData(:final value) => value.contains(trackId),
      _ => false,
    };

    return Material(
      color: isFavorite 
          ? const Color(0xFFFEE2E2) 
          : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.05),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          if (isFavorite) {
            ref.read(favoriteTracksProvider.notifier).removeTrack(trackId);
          } else {
            ref.read(favoriteTracksProvider.notifier).addTrack(trackId);
          }
        },
        child: Container(
          padding: EdgeInsets.all(10.r),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 200),
            transitionBuilder: (child, animation) {
              return ScaleTransition(scale: animation, child: child);
            },
            child: Icon(
              isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
              key: ValueKey(isFavorite),
              color: isFavorite 
                  ? const Color(0xFFEF4444) 
                  : Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.5),
              size: 24.r,
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildFavoriteButton(
  Track trackSelected,
  BuildContext context,
) =>
    HeartIcon(trackId: trackSelected.id);

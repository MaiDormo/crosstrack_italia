import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/tracks_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllTracksView extends ConsumerWidget {
  const AllTracksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var tracks = ref.watch(fetchAllTracksProvider);
    return RefreshIndicator(
      onRefresh: () {
        tracks = ref.refresh(fetchAllTracksProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: tracks.when(
        data: (tracks) {
          if (tracks.isEmpty) {
            return const Icon(Icons.question_mark);
          } else {
            return TracksListView(
              tracks: tracks,
            );
          }
        },
        error: (error, stackTrace) => const Icon(Icons.error),
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}

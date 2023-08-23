import 'package:crosstrack_italia/states/track_info/providers/all_track_info_provider.dart';
import 'package:crosstrack_italia/views/components/animations/empty_contents_with_text_animation_view.dart';
import 'package:crosstrack_italia/views/components/animations/error_animation_view.dart';
import 'package:crosstrack_italia/views/components/animations/loading_animation_view.dart';
import 'package:crosstrack_italia/views/components/constants/strings.dart';
import 'package:crosstrack_italia/views/components/tracks/tracks_list_view.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AllTracksView extends ConsumerWidget {
  const AllTracksView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracks = ref.watch(allTrackInfoProvider);
    return RefreshIndicator(
      onRefresh: () {
        ref.refresh(allTrackInfoProvider);
        return Future.delayed(
          const Duration(
            seconds: 1,
          ),
        );
      },
      child: tracks.when(
        data: (tracks) {
          if (tracks.isEmpty) {
            return const EmptyContentsWithTextAnimationView(
              text: Strings.noTracksAvaiable,
            );
          } else {
            return TracksListView(
              tracks: tracks,
            );
          }
        },
        error: (error, stackTrace) => const ErrorAnimationView(),
        loading: () => const LoadingAnimationView(),
      ),
    );
  }
}

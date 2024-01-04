import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_selector.g.dart';

@riverpod
class SelectedTracks extends _$SelectedTracks {
  @override
  List<Track?> build() {
    return [null, null];
  }

  void add(Track track, int index) {
    index == 0 ? state = [track, state[1]] : state = [state[0], track];
  }

  void remove(int index) {
    index == 0 ? state = [null, state[1]] : state = [state[0], null];
  }
}

class TrackSelector extends ConsumerWidget {
  const TrackSelector({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Iterable<Track>> allTracks =
        ref.watch(fetchAllTracksProvider);
    return switch (allTracks) {
      AsyncData(:final value) => Card(
          margin: EdgeInsets.symmetric(horizontal: 4.0.w, vertical: 8.0.h),
          color: Theme.of(context).colorScheme.secondary,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: 16.sp),
                Text(
                  "Scegli il primo tracciato:",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                8.verticalSpace,
                TrackDropDown(tracks: value, trackNumber: 0),
                16.verticalSpace,
                Text(
                  "Scegli il secondo tracciato:",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                ),
                8.verticalSpace,
                TrackDropDown(tracks: value, trackNumber: 1),
              ],
            ),
          ),
        ),
      AsyncError() =>
        const Center(child: Text("Errore nel caricamento dei tracciati")),
      _ => const Center(child: CircularProgressIndicator())
    };
  }
}

class TrackDropDown extends ConsumerWidget {
  final Iterable<Track> tracks;
  final int trackNumber;
  const TrackDropDown({
    Key? key,
    required this.tracks,
    required this.trackNumber,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<Track?> selectedTracks = ref.watch(selectedTracksProvider);
    return DropdownButton<Track>(
      value: selectedTracks[trackNumber],
      dropdownColor: Theme.of(context).colorScheme.secondary,
      borderRadius: const BorderRadius.all(Radius.circular(20.0)),
      style: TextStyle(
        color: Theme.of(context).colorScheme.onSecondary,
        fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
      ),
      onChanged: (selectedTrack) {
        if (selectedTrack != null) {
          ref
              .read(selectedTracksProvider.notifier)
              .add(selectedTrack, trackNumber);
        } else {
          ref.read(selectedTracksProvider.notifier).remove(
                trackNumber,
              );
        }
      },
      isExpanded: true,
      items: [
        DropdownMenuItem<Track>(
          value: null,
          child: Text(
            "Nessuna scelta",
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ),
        ...tracks.map<DropdownMenuItem<Track>>((Track track) {
          return DropdownMenuItem<Track>(
            value: track,
            child: Text(track.trackName),
          );
        }).toList(),
      ],
    );
  }
}

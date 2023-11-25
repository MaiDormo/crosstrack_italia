import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/track_comparison.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_selection_screen.g.dart';

@riverpod
class SelectedTracks extends _$SelectedTracks {
  @override
  List<Track> build() {
    return [];
  }

  void add(Track track) {
    state = [...state, track];
  }

  void remove(Track track) {
    state = state.where((element) => element != track).toList();
  }
}

class TrackSelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Iterable<Track>> allTracks =
        ref.watch(fetchAllTracksProvider);
    final List<Track> selectedTracks = ref.watch(selectedTracksProvider);
    final AsyncValue<Position?> userLocation = ref.watch(getPositionProvider);
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);

    Widget _buildLocationSelector() {
      return userLocation.when(
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) => Text("Error loading location: $error"),
        data: (userLocation) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Text("Provide your location:"),
              SizedBox(height: 8),
              Row(
                children: [
                  Text("Location: "),
                  if (userLocation != null)
                    Text(
                      "${userLocation.latitude}, ${userLocation.longitude}",
                    ),
                ],
              ),
              SizedBox(height: 8),
              Checkbox(
                value: userLocation != null,
                onChanged: (value) async {
                  if (value!) {
                    ref.read(showCurrentLocationProvider.notifier).toggle();
                  }
                },
              ),
            ],
          );
        },
      );
    }

    Widget _buildComparisonButton(BuildContext context) {
      return ElevatedButton(
        onPressed: () {
          if (selectedTracks.length == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrackComparison(
                  track1: selectedTracks[0],
                  track2: selectedTracks[1],
                  userLocationAvailable: showCurrentLocation,
                  userLatitude: ref.watch(getPositionProvider).when(
                            data: (value) => value?.latitude,
                            loading: () => 0.0,
                            error: (error, stackTrace) => 0.0,
                          ) ??
                      0.0,
                  userLongitude: ref.watch(getPositionProvider).when(
                            data: (value) => value?.longitude,
                            loading: () => 0.0,
                            error: (error, stackTrace) => 0.0,
                          ) ??
                      0.0,
                ),
              ),
            );
          } else {
            // Inform the user to select two tracks
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Please select two tracks."),
              ),
            );
          }
        },
        child: Text("Compare Tracks"),
      );
    }

    Widget _buildTrackDropdown(
      Iterable<Track> tracks,
      List<Track> selectedTracks,
      int trackNumber,
    ) {
      return DropdownButton<Track>(
        value: selectedTracks.length > trackNumber
            ? selectedTracks[trackNumber]
            : null,
        onChanged: (selectedTrack) {
          if (selectedTrack != null) {
            ref.read(selectedTracksProvider.notifier).add(selectedTrack);
          } else {
            ref.read(selectedTracksProvider.notifier).remove(
                  selectedTracks[trackNumber],
                );
          }
        },
        isExpanded: true,
        items: [
          DropdownMenuItem<Track>(
            value: null,
            child: Text("Nessuna scelta"),
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

    Widget _buildTrackSelector(Iterable<Track> tracks) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text("Select Track 1:"),
          SizedBox(height: 8),
          _buildTrackDropdown(tracks, selectedTracks, 0),
          SizedBox(height: 16),
          Text("Select Track 2:"),
          SizedBox(height: 8),
          _buildTrackDropdown(tracks, selectedTracks, 1),
        ],
      );
    }

    Widget _buildSelectionForm(
      BuildContext context,
      Iterable<Track> tracks,
    ) {
      return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buildTrackSelector(tracks),
              _buildLocationSelector(),
              SizedBox(height: 16),
              _buildComparisonButton(context),
            ],
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Scaffold(
          body: allTracks.when(
            loading: () => Center(child: CircularProgressIndicator()),
            error: (error, stackTrace) =>
                Center(child: Text("Error loading tracks: $error")),
            data: (tracks) {
              return _buildSelectionForm(context, tracks);
            },
          ),
        ),
      ),
    );
  }
}

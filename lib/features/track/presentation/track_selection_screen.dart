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

class TrackSelectionScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<Iterable<Track>> allTracks =
        ref.watch(fetchAllTracksProvider);
    final List<Track?> selectedTracks = ref.watch(selectedTracksProvider);
    final AsyncValue<Position?> userLocation = ref.watch(getPositionProvider);
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);

    Widget _buildLocationSelector() {
      return userLocation.when(
        loading: () => CircularProgressIndicator(),
        error: (error, stackTrace) =>
            Text("Errore nel caricamento della posizione"),
        data: (userLocation) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 16),
              Text(
                "Condividi la tua posizione:",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Posizione: "),
                  if (userLocation != null)
                    Text(
                      ref.watch(getClosestLocationProvider).when(
                                data: (value) => value,
                                loading: () => "Caricamento...",
                                error: (error, stackTrace) => "Errore",
                              ) ??
                          "",
                    ),
                ],
              ),
              SizedBox(height: 8),
              Checkbox(
                value: showCurrentLocation,
                onChanged: (value) async =>
                    ref.read(showCurrentLocationProvider.notifier).toggle(),
              ),
            ],
          );
        },
      );
    }

    Widget _buildComparisonButton(BuildContext context) {
      return ElevatedButton(
        onPressed: () {
          if (selectedTracks[0] != null && selectedTracks[1] != null) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TrackComparison(
                  track1: selectedTracks[0]!,
                  track2: selectedTracks[1]!,
                  userLocationAvailable: showCurrentLocation,
                  userLatitude: ref.read(getPositionProvider).when(
                            data: (value) => value?.latitude,
                            loading: () => 0.0,
                            error: (error, stackTrace) => 0.0,
                          ) ??
                      0.0,
                  userLongitude: ref.read(getPositionProvider).when(
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
                content: Text("Seleziona due tracciati tra i disponibliti."),
              ),
            );
          }
        },
        child: Text("Confronta"),
      );
    }

    Widget _buildTrackDropdown(
      Iterable<Track> tracks,
      List<Track?> selectedTracks,
      int trackNumber,
    ) {
      return DropdownButton<Track>(
        value: selectedTracks[trackNumber],
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
          Text(
            "Scegli il primo tracciato:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          SizedBox(height: 8),
          _buildTrackDropdown(tracks, selectedTracks, 0),
          SizedBox(height: 16),
          Text(
            "Scegli il secondo tracciato:",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
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

    return Hero(
      tag: "track_selection_screen",
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Scaffold(
            backgroundColor: Theme.of(context).colorScheme.secondary,
            body: allTracks.when(
              loading: () => Center(child: CircularProgressIndicator()),
              error: (error, stackTrace) =>
                  Center(child: Text("Errore nel caricamento dei tracciati")),
              data: (tracks) {
                return _buildSelectionForm(context, tracks);
              },
            ),
          ),
        ),
      ),
    );
  }
}

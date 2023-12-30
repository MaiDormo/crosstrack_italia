import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/track_comparison.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(
          child: Text(
            "Errore nel caricamento della posizione: $error",
            style: TextStyle(
              color: Theme.of(context).colorScheme.error,
            ),
          ),
        ),
        data: (userLocation) {
          return Padding(
            padding: EdgeInsets.all(16.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                16.verticalSpace,
                Text(
                  "Condividi la tua posizione:",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                8.verticalSpace,
                ListTile(
                  title: Text(
                    "Posizione: ",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: userLocation != null && showCurrentLocation
                      ? ref.watch(getClosestLocationProvider).when(
                          data: (value) => Text(
                                value,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                          loading: () =>
                              const Center(child: CircularProgressIndicator()),
                          error: (error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "Errore nel caricamento della posizione: $error"),
                              ),
                            );
                            return null;
                          })
                      : Text(""),
                  trailing: Tooltip(
                    message: showCurrentLocation
                        ? 'Disable location'
                        : 'Enable location',
                    child: IconButton(
                      icon: Icon(
                        showCurrentLocation
                            ? Icons.location_off
                            : Icons.location_on,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () async {
                        if (showCurrentLocation) {
                          final confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: Text('Conferma'),
                              content: Text(
                                  'Sei sicuro di voler rimuovere la posizione?'),
                              actions: [
                                TextButton(
                                  child: Text('Annulla'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  child: Text('Conferma'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );
                          if (confirm) {
                            ref
                                .read(showCurrentLocationProvider.notifier)
                                .toggle();
                          }
                        } else {
                          ref
                              .read(showCurrentLocationProvider.notifier)
                              .toggle();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }

    Widget _buildComparisonButton(BuildContext context) {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.blueGrey,
          backgroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
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

    Widget _buildTrackSelector(Iterable<Track> tracks) {
      return Card(
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
              _buildTrackDropdown(tracks, selectedTracks, 0),
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
              _buildTrackDropdown(tracks, selectedTracks, 1),
            ],
          ),
        ),
      );
    }

    Widget _buildSelectionForm(
      BuildContext context,
      Iterable<Track> tracks,
    ) {
      return SingleChildScrollView(
        padding: const EdgeInsets.all(16.0).r,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildTrackSelector(tracks),
            _buildLocationSelector(),
            SizedBox(height: 16.sp),
            _buildComparisonButton(context),
          ],
        ),
      );
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Confronto Tracciati'),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: allTracks.when(
          loading: () => Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) =>
              Center(child: Text("Errore nel caricamento dei tracciati")),
          data: (tracks) {
            return _buildSelectionForm(context, tracks);
          },
        ),
      ),
    );
  }
}

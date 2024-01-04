import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/track_comparison.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/track_selector.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ComparisonButton extends ConsumerWidget {
  const ComparisonButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTracks = ref.watch(selectedTracksProvider);
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);
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
}

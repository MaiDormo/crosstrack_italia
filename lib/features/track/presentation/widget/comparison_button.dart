import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/track_comparison.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/track_selector.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ComparisonButton extends ConsumerStatefulWidget {
  const ComparisonButton({
    Key? key,
  }) : super(key: key);

  @override
  _ComparisonButtonState createState() => _ComparisonButtonState();
}

class _ComparisonButtonState extends ConsumerState<ComparisonButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final selectedTracks = ref.watch(selectedTracksProvider);
    final position = ref.watch(getPositionProvider);

    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.blueGrey,
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      onPressed: _isLoading
          ? null
          : () async {
              if (selectedTracks[0] != null && selectedTracks[1] != null) {
                setState(() {
                  _isLoading = true;
                });
                await switch (position) {
                  AsyncData(:final value) => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackComparison(
                          track1: selectedTracks[0]!,
                          track2: selectedTracks[1]!,
                          userLocationAvailable: value != null,
                          userLocation: value,
                        ),
                      ),
                    ),
                  AsyncError() => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TrackComparison(
                          track1: selectedTracks[0]!,
                          track2: selectedTracks[1]!,
                          userLocationAvailable: false,
                          userLocation: null,
                        ),
                      ),
                    ),
                  _ => ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("Caricando..."),
                      ),
                    ),
                };
                setState(() {
                  _isLoading = false;
                });
              } else {
                // Inform the user to select two tracks
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content:
                        Text("Seleziona due tracciati tra i disponibliti."),
                  ),
                );
              }
            },
      child: _isLoading
          ? CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            )
          : Text("Confronta"),
    );
  }
}

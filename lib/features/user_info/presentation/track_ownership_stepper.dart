import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:crosstrack_italia/features/user_info/providers/owned_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackOwnershipStepper extends ConsumerStatefulWidget {
  @override
  _TrackOwnershipStepperState createState() => _TrackOwnershipStepperState();
}

class _TrackOwnershipStepperState extends ConsumerState<TrackOwnershipStepper> {
  int _currentStep = 0;
  final Set<Track> _selectedTracks = {};
  late final AsyncValue<Iterable<Track>> allTracks =
      ref.watch(fetchAllTracksProvider);
  late AsyncValue<UserInfoModel> _userState =
      ref.watch(userStateNotifierProvider);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestione Tracciato'),
        ),
        body: switch (_userState) {
          AsyncData(:final value) => Stepper(
              currentStep: _currentStep,
              onStepContinue: () {
                if (_currentStep == 2) {
                  if (value.isOwner != true) {
                    ref.read(userStateNotifierProvider.notifier).makeOwner(
                          _selectedTracks.map((track) => track.id).toList(),
                        );
                  } else {
                    ref.read(ownedTracksNotifierProvider.notifier).addTracks(
                          _selectedTracks.map((track) => track.id).toList(),
                        );
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                          '${_selectedTracks.length} tracciati aggiunti ai tuoi posseduti'),
                    ),
                  );
                }

                if (_currentStep >= 2) return;
                setState(() {
                  _currentStep += 1;
                });
              },
              onStepCancel: () {
                if (_currentStep <= 0) return;
                setState(() {
                  _currentStep -= 1;
                });
              },
              steps: [
                Step(
                  title: const Text('Possiedi un tracciato?'),
                  content: Text('Conferma che possiedi un tracciato.'),
                ),
                Step(
                  title: const Text('Seleziona i tracciati che possiedi'),
                  content: allTracks.when(
                    data: (value) => Container(
                      height: 438.3.h,
                      child: ListView.builder(
                        itemCount: value.length,
                        itemBuilder: (context, index) {
                          final track = value.elementAt(index);
                          return CheckboxListTile(
                            title: Text(track.trackName),
                            value: _selectedTracks.contains(track),
                            onChanged: (bool? value) {
                              setState(() {
                                if (value == true) {
                                  _selectedTracks.add(track);
                                } else {
                                  _selectedTracks.remove(track);
                                }
                              });
                            },
                          );
                        },
                      ),
                    ),
                    loading: () => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    error: (error, _) => Center(
                      child: Text(
                        error.toString(),
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ),
                Step(
                  title: const Text('Modifica i tuoi tracciati'),
                  content: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(
                        style: Theme.of(context).textTheme.bodyMedium,
                        children: <TextSpan>[
                          TextSpan(
                            text:
                                'Puoi modificare i tuoi tracciati premendo:\n',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                          TextSpan(
                            text:
                                'Tracciati > Gestione Tracciati > Tracciato che vuole modificare',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.sp,
                                color: Colors.blue),
                          ),
                          TextSpan(
                            text: '.',
                            style: TextStyle(fontSize: 16.sp),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                )
              ],
            ),
          AsyncError(:final error) => Center(
              child: Text(
                'Error' + error.toString(),
                style: const TextStyle(color: Colors.red),
              ),
            ),
          _ => const Center(
              child: CircularProgressIndicator(),
            ),
        },
      ),
    );
  }
}

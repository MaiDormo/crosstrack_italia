import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/models/user_info_model.dart';
import 'package:crosstrack_italia/features/user_info/models/user_roles.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/owned_tracks_notifier.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:crosstrack_italia/features/user_info/presentation/owned_tracks_screen.dart';
import 'package:crosstrack_italia/views/components/bottom_bar/nav_states/nav_notifier.dart';
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
      ref.read(fetchAllTracksProvider);
  late AsyncValue<UserInfoModel> _userState =
      ref.watch(userStateNotifierProvider);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Text('Gestione Tracciato'),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _userState.when(
      data: (value) => _buildStepper(context, value),
      error: (error, _) => _buildError(context, error),
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildStepper(BuildContext context, UserInfoModel userInfo) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.0.h),
      child: Stepper(
        controlsBuilder: (context, details) => _buildControls(context, details),
        currentStep: _currentStep,
        onStepContinue: _handleStepContinue,
        onStepCancel: _handleStepCancel,
        steps: _buildSteps(context, userInfo),
      ),
    );
  }

  Widget _buildControls(BuildContext context, ControlsDetails details) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStepButton(context, 'Continua', details.onStepContinue),
        if (_currentStep != 0)
          _buildStepButton(context, 'Ritorna', details.onStepCancel),
      ],
    );
  }

  Widget _buildStepButton(
      BuildContext context, String text, VoidCallback? onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: text == 'Continua'
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).primaryColor,
        backgroundColor: text == 'Continua'
            ? Theme.of(context).primaryColor
            : Theme.of(context).colorScheme.tertiary,
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  List<Step> _buildSteps(BuildContext context, UserInfoModel userInfo) {
    return [
      Step(
        title: const Text('Possiedi un tracciato?'),
        content: const Text('Conferma che possiedi un tracciato.'),
        isActive: _currentStep == 0,
      ),
      Step(
        title: const Text('Seleziona i tracciati che possiedi'),
        content: _buildTracksSelection(context),
        isActive: _currentStep == 1,
      ),
      Step(
        title: const Text('Modifica i tuoi tracciati'),
        content: _buildModifyTracksContent(context),
        isActive: _currentStep == 2,
      ),
    ];
  }

  Widget _buildTracksSelection(BuildContext context) {
    return allTracks.when(
      data: (tracks) => _buildTracksListView(context, tracks),
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => _buildError(context, error),
    );
  }

  Widget _buildTracksListView(BuildContext context, Iterable<Track> tracks) {
    // Sort tracks by trackName
    final sortedTracks = tracks.toList()
      ..sort((a, b) => a.trackName.compareTo(b.trackName));

    return SizedBox(
      height: 438.3.h,
      child: ListView.builder(
        itemCount: sortedTracks.length,
        itemBuilder: (context, index) {
          final track = sortedTracks[index];
          return CheckboxListTile(
            title: Text(
              track.trackName,
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            value: _selectedTracks.contains(track),
            onChanged: (bool? selected) {
              setState(() {
                if (selected == true) {
                  _selectedTracks.add(track);
                } else {
                  _selectedTracks.remove(track);
                }
              });
            },
          );
        },
      ),
    );
  }

  Widget _buildModifyTracksContent(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: Theme.of(context).textTheme.bodyMedium,
        children: [
          TextSpan(text: 'Puoi modificare i tuoi tracciati premendo:\n'),
          TextSpan(
            text:
                'Tracciati > Gestione Tracciati > Tracciato che vuole modificare',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).primaryColor,
            ),
          ),
          TextSpan(text: '.'),
        ],
      ),
    );
  }

  void _handleStepContinue() {
    if (_currentStep < 2) {
      setState(() => _currentStep++);
    } else {
      _handleFinalStep();
    }
  }

  void _handleStepCancel() {
    if (_currentStep > 0) {
      setState(() => _currentStep--);
    }
  }

  void _handleFinalStep() {
    final userRole = _userState.value?.role;
    final trackIds = _selectedTracks.map((track) => track.id).toList();

    if (trackIds.isEmpty) {
      _showSnackBar(context, 'Devi selezionare almeno un tracciato');
      return;
    }

    if (userRole == UserRole.user) {
      ref.read(userStateNotifierProvider.notifier).makeOwner(trackIds);
    } else {
      ref.read(ownedTracksNotifierProvider.notifier).addTracks(trackIds);
    }

    _showSnackBar(
      context,
      '${_selectedTracks.length} tracciat' +
          (_selectedTracks.length == 1 ? 'o' : 'i') +
          ' aggiunt' +
          (_selectedTracks.length == 1 ? 'o' : 'i') +
          ' ai tuoi posseduti',
    );
    _navigateToOwnedTracksScreen(context);
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToOwnedTracksScreen(BuildContext context) {
    Navigator.of(context).pop();
    ref.read(navNotifierProvider.notifier).onIndexChanged(1);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OwnedTracksScreen()),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    return Center(
      child: Text(
        'Errore: ${error.toString()}',
        style: TextStyle(color: Theme.of(context).colorScheme.error),
      ),
    );
  }
}

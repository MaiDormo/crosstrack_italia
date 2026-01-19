import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../views/components/bottom_bar/nav_states/nav_notifier.dart';
import '../../track/models/track.dart';
import '../../track/notifiers/track_notifier.dart';
import '../models/user_info_model.dart';
import '../models/user_roles.dart';
import '../notifiers/owned_tracks_notifier.dart';
import '../notifiers/user_state_notifier.dart';
import 'owned_tracks_screen.dart';

class TrackOwnershipStepper extends ConsumerStatefulWidget {
  const TrackOwnershipStepper({super.key});

  @override
  _TrackOwnershipStepperState createState() => _TrackOwnershipStepperState();
}

class _TrackOwnershipStepperState extends ConsumerState<TrackOwnershipStepper> {
  int _currentStep = 0;
  final Set<Track> _selectedTracks = {};
  late final AsyncValue<Iterable<Track>> allTracks =
      ref.read(fetchAllTracksProvider);
  late final AsyncValue<UserInfoModel> _userState =
      ref.watch(userStateProvider);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          title: Text(
            'Inserisci i tuoi tracciati',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
        ),
        body: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _userState.when(
      data: (value) => _buildStepper(context, value),
      error: (error, _) => _buildError(context, error),
      loading: () => Center(
        child: CircularProgressIndicator(
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildStepper(BuildContext context, UserInfoModel userInfo) {
    final colorScheme = Theme.of(context).colorScheme;

    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: colorScheme.copyWith(
          primary: colorScheme.primary,
          onSurface: colorScheme.onSurface,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.0.h),
        child: Stepper(
          controlsBuilder: (context, details) =>
              _buildControls(context, details),
          currentStep: _currentStep,
          onStepContinue: _handleStepContinue,
          onStepCancel: _handleStepCancel,
          steps: _buildSteps(context, userInfo),
          stepIconBuilder: (stepIndex, stepState) {
            return Container(
              width: 28.r,
              height: 28.r,
              decoration: BoxDecoration(
                color: stepState == StepState.complete || _currentStep >= stepIndex
                    ? colorScheme.primary
                    : colorScheme.onSurface.withValues(alpha: 0.3),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: stepState == StepState.complete
                    ? Icon(Icons.check, color: Colors.white, size: 16.r)
                    : Text(
                        '${stepIndex + 1}',
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildControls(BuildContext context, ControlsDetails details) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Row(
        children: [
          // Continue button - primary blue
          Expanded(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: colorScheme.primary,
                elevation: 0,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onPressed: details.onStepContinue,
              child: Text(
                _currentStep == 2 ? 'Conferma' : 'Continua',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          if (_currentStep != 0) ...[
            SizedBox(width: 12.w),
            // Back button - outlined style
            Expanded(
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: colorScheme.primary,
                  side: BorderSide(color: colorScheme.primary),
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: details.onStepCancel,
                child: Text(
                  'Indietro',
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14.sp,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Step> _buildSteps(BuildContext context, UserInfoModel userInfo) {
    final colorScheme = Theme.of(context).colorScheme;

    return [
      Step(
        title: Text(
          'Possiedi un tracciato?',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            color: colorScheme.onSurface,
          ),
        ),
        content: Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: colorScheme.primary.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.help_outline_rounded,
                  color: colorScheme.primary,
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Conferma che possiedi un tracciato per procedere con la registrazione.',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.8),
                  ),
                ),
              ),
            ],
          ),
        ),
        isActive: _currentStep >= 0,
        state: _currentStep > 0 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Seleziona i tracciati',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            color: colorScheme.onSurface,
          ),
        ),
        subtitle: Text(
          '${_selectedTracks.length} selezionati',
          style: GoogleFonts.poppins(
            fontSize: 12.sp,
            color: colorScheme.primary,
            fontWeight: FontWeight.w500,
          ),
        ),
        content: _buildTracksSelection(context),
        isActive: _currentStep >= 1,
        state: _currentStep > 1 ? StepState.complete : StepState.indexed,
      ),
      Step(
        title: Text(
          'Modifica i tuoi tracciati',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w600,
            fontSize: 15.sp,
            color: colorScheme.onSurface,
          ),
        ),
        content: _buildModifyTracksContent(context),
        isActive: _currentStep >= 2,
        state: StepState.indexed,
      ),
    ];
  }

  Widget _buildTracksSelection(BuildContext context) {
    return allTracks.when(
      data: (tracks) => _buildTracksListView(context, tracks),
      loading: () => Center(
        child: Padding(
          padding: EdgeInsets.all(32.r),
          child: CircularProgressIndicator(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
      ),
      error: (error, _) => _buildError(context, error),
    );
  }

  Widget _buildTracksListView(BuildContext context, Iterable<Track> tracks) {
    final colorScheme = Theme.of(context).colorScheme;

    // Sort tracks by trackName
    final sortedTracks = tracks.toList()
      ..sort((a, b) => a.trackName.compareTo(b.trackName));

    return Container(
      height: 400.h,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colorScheme.onSurface.withValues(alpha: 0.08),
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: ListView.separated(
          itemCount: sortedTracks.length,
          separatorBuilder: (context, index) => Divider(
            height: 1,
            color: colorScheme.onSurface.withValues(alpha: 0.06),
          ),
          itemBuilder: (context, index) {
            final track = sortedTracks[index];
            final isSelected = _selectedTracks.contains(track);

            return Material(
              color: isSelected
                  ? colorScheme.primary.withValues(alpha: 0.05)
                  : Colors.transparent,
              child: InkWell(
                onTap: () {
                  setState(() {
                    if (isSelected) {
                      _selectedTracks.remove(track);
                    } else {
                      _selectedTracks.add(track);
                    }
                  });
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                  child: Row(
                    children: [
                      // Track icon
                      Container(
                        width: 40.r,
                        height: 40.r,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primary
                              : colorScheme.primary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          Icons.terrain_rounded,
                          color: isSelected ? Colors.white : colorScheme.primary,
                          size: 20.r,
                        ),
                      ),
                      SizedBox(width: 12.w),
                      // Track info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              track.trackName,
                              style: GoogleFonts.poppins(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: colorScheme.onSurface,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              track.region,
                              style: GoogleFonts.poppins(
                                fontSize: 12.sp,
                                color:
                                    colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Checkbox
                      Container(
                        width: 24.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          color: isSelected
                              ? colorScheme.primary
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: isSelected
                                ? colorScheme.primary
                                : colorScheme.onSurface.withValues(alpha: 0.3),
                            width: 2,
                          ),
                        ),
                        child: isSelected
                            ? Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 16.r,
                              )
                            : null,
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildModifyTracksContent(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D5A).withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xFF2E7D5A).withValues(alpha: 0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: const Color(0xFF2E7D5A).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  Icons.check_circle_outline_rounded,
                  color: const Color(0xFF2E7D5A),
                  size: 24.r,
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Quasi finito!',
                  style: GoogleFonts.poppins(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF2E7D5A),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12.h),
          Text(
            'Puoi modificare i tuoi tracciati in qualsiasi momento seguendo questo percorso:',
            style: GoogleFonts.poppins(
              fontSize: 13.sp,
              color: colorScheme.onSurface.withValues(alpha: 0.7),
            ),
          ),
          SizedBox(height: 12.h),
          Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                _buildPathStep(context, 'Tracciati', Icons.map_rounded),
                _buildPathArrow(),
                _buildPathStep(context, 'Gestione', Icons.edit_road_rounded),
                _buildPathArrow(),
                _buildPathStep(context, 'Modifica', Icons.edit_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPathStep(BuildContext context, String label, IconData icon) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: colorScheme.primary, size: 20.r),
          SizedBox(height: 4.h),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildPathArrow() {
    return Icon(
      Icons.chevron_right_rounded,
      color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.3),
      size: 20.r,
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

  Future<void> _handleFinalStep() async {
    final userRole = _userState.value?.role;
    final trackIds = _selectedTracks.map((track) => track.id).toList();

    if (trackIds.isEmpty) {
      _showSnackBar(context, 'Devi selezionare almeno un tracciato', isError: true);
      return;
    }

    // Show loading state could be added here if desired
    try {
      if (userRole == UserRole.user) {
        await ref.read(userStateProvider.notifier).makeOwner(trackIds);
      } else {
        await ref.read(ownedTracksProvider.notifier).addTracks(trackIds);
      }

      // Only navigate and show success message if still mounted
      if (!mounted) return;

      _showSnackBar(
        context,
        '${_selectedTracks.length} tracciat${_selectedTracks.length == 1 ? 'o' : 'i'} aggiunt${_selectedTracks.length == 1 ? 'o' : 'i'} ai tuoi posseduti',
      );
      _navigateToOwnedTracksScreen(context);
    } catch (e) {
      if (!mounted) return;
      _showSnackBar(context, 'Errore: $e', isError: true);
    }
  }

  void _showSnackBar(BuildContext context, String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
          ),
        ),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        backgroundColor: isError ? const Color(0xFFEF4444) : const Color(0xFF2E7D5A),
      ),
    );
  }

  void _navigateToOwnedTracksScreen(BuildContext context) {
    Navigator.of(context).pop();
    ref.read(navProvider.notifier).onIndexChanged(1);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const OwnedTracksScreen()),
    );
  }

  Widget _buildError(BuildContext context, Object error) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.r,
              color: const Color(0xFFEF4444),
            ),
            SizedBox(height: 16.h),
            Text(
              'Errore',
              style: GoogleFonts.poppins(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error.toString(),
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/track_comparison.dart';
import 'package:crosstrack_italia/features/track/presentation/widget/track_selector.dart';
import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrackSelectionScreen extends ConsumerStatefulWidget {
  const TrackSelectionScreen({super.key});

  @override
  ConsumerState<TrackSelectionScreen> createState() => _TrackSelectionScreenState();
}

class _TrackSelectionScreenState extends ConsumerState<TrackSelectionScreen> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final allTracks = ref.watch(fetchAllTracksProvider);
    final selectedTracks = ref.watch(selectedTracksProvider);
    final position = ref.watch(getPositionProvider);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
        elevation: 0,
        title: const Text(
          'Confronto Tracciati',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: allTracks.when(
        data: (tracks) => _buildContent(
          context,
          tracks,
          selectedTracks,
          position,
          colorScheme,
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Padding(
            padding: EdgeInsets.all(32.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline_rounded,
                  size: 60.r,
                  color: const Color(0xFFEF4444),
                ),
                SizedBox(height: 16.h),
                Text(
                  'Errore nel caricamento',
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  error.toString(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
    BuildContext context,
    Iterable<Track> tracks,
    List<Track?> selectedTracks,
    AsyncValue<geo.Position?> position,
    ColorScheme colorScheme,
  ) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: Text(
              'Seleziona due tracciati da confrontare',
              style: TextStyle(
                fontSize: 16.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ),

          // Track 1 Selection
          _buildTrackSelector(
            context: context,
            label: 'Primo Tracciato',
            trackNumber: 1,
            selectedTrack: selectedTracks[0],
            tracks: tracks,
            colorScheme: colorScheme,
            onSelected: (track) {
              if (track != null) {
                ref.read(selectedTracksProvider.notifier).add(track, 0);
              } else {
                ref.read(selectedTracksProvider.notifier).remove(0);
              }
            },
          ),

          SizedBox(height: 16.h),

          // VS Divider
          Center(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                'VS',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w700,
                  color: colorScheme.primary,
                ),
              ),
            ),
          ),

          SizedBox(height: 16.h),

          // Track 2 Selection
          _buildTrackSelector(
            context: context,
            label: 'Secondo Tracciato',
            trackNumber: 2,
            selectedTrack: selectedTracks[1],
            tracks: tracks,
            colorScheme: colorScheme,
            onSelected: (track) {
              if (track != null) {
                ref.read(selectedTracksProvider.notifier).add(track, 1);
              } else {
                ref.read(selectedTracksProvider.notifier).remove(1);
              }
            },
          ),

          SizedBox(height: 32.h),

          // Compare Button
          _buildCompareButton(
            context: context,
            selectedTracks: selectedTracks,
            position: position,
            colorScheme: colorScheme,
          ),

          SizedBox(height: 16.h),
        ],
      ),
    );
  }

  Widget _buildTrackSelector({
    required BuildContext context,
    required String label,
    required int trackNumber,
    required Track? selectedTrack,
    required Iterable<Track> tracks,
    required ColorScheme colorScheme,
    required Function(Track?) onSelected,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: colorScheme.shadow.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: colorScheme.primary.withValues(alpha: 0.05),
              borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Row(
              children: [
                Container(
                  width: 36.r,
                  height: 36.r,
                  decoration: BoxDecoration(
                    color: colorScheme.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(
                    child: Text(
                      '$trackNumber',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        color: colorScheme.onPrimary,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: colorScheme.onSurface,
                  ),
                ),
                const Spacer(),
                if (selectedTrack != null)
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2E7D5A).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check_circle_rounded,
                          size: 14.r,
                          color: const Color(0xFF2E7D5A),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'Selezionato',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF2E7D5A),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
          // Dropdown
          Padding(
            padding: EdgeInsets.all(16.r),
            child: DropdownButtonFormField<Track>(
              value: selectedTrack,
              decoration: InputDecoration(
                hintText: 'Seleziona un tracciato',
                hintStyle: TextStyle(
                  color: colorScheme.onSurface.withValues(alpha: 0.4),
                ),
                filled: true,
                fillColor: colorScheme.surface,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colorScheme.onSurface.withValues(alpha: 0.1),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                    color: colorScheme.primary,
                    width: 2,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
              ),
              dropdownColor: colorScheme.surface,
              borderRadius: BorderRadius.circular(12),
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              items: [
                DropdownMenuItem<Track>(
                  value: null,
                  child: Text(
                    'Nessuna scelta',
                    style: TextStyle(
                      color: colorScheme.onSurface.withValues(alpha: 0.5),
                    ),
                  ),
                ),
                ...tracks.map((track) => DropdownMenuItem<Track>(
                  value: track,
                  child: Text(
                    track.trackName,
                    style: TextStyle(
                      color: colorScheme.onSurface,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )),
              ],
              onChanged: onSelected,
            ),
          ),
          // Selected track preview
          if (selectedTrack != null)
            Padding(
              padding: EdgeInsets.fromLTRB(16.r, 0, 16.r, 16.r),
              child: Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 40.r,
                      height: 40.r,
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.terrain_rounded,
                        color: colorScheme.primary,
                        size: 20.r,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            selectedTrack.trackName,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            '${selectedTrack.region} • ${selectedTrack.location}',
                            style: TextStyle(
                              fontSize: 12.sp,
                              color: colorScheme.onSurface.withValues(alpha: 0.6),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCompareButton({
    required BuildContext context,
    required List<Track?> selectedTracks,
    required AsyncValue<geo.Position?> position,
    required ColorScheme colorScheme,
  }) {
    final isEnabled = selectedTracks[0] != null && selectedTracks[1] != null;

    return SizedBox(
      width: double.infinity,
      child: Material(
        color: isEnabled ? colorScheme.primary : colorScheme.onSurface.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: isEnabled && !_isLoading
              ? () => _onCompare(context, selectedTracks, position)
              : null,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 18.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  SizedBox(
                    width: 20.r,
                    height: 20.r,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: colorScheme.onPrimary,
                    ),
                  )
                else ...[
                  Icon(
                    Icons.compare_arrows_rounded,
                    color: isEnabled ? colorScheme.onPrimary : colorScheme.onSurface.withValues(alpha: 0.3),
                    size: 22.r,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Confronta Tracciati',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: isEnabled ? colorScheme.onPrimary : colorScheme.onSurface.withValues(alpha: 0.3),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _onCompare(
    BuildContext context,
    List<Track?> selectedTracks,
    AsyncValue<geo.Position?> position,
  ) async {
    setState(() => _isLoading = true);

    try {
      final positionValue = position.value;
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrackComparison(
            track1: selectedTracks[0]!,
            track2: selectedTracks[1]!,
            userLocationAvailable: positionValue != null,
            userLocation: positionValue,
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }
}

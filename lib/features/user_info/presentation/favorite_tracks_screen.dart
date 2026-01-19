import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

import '../../map/presentation/panel_widget.dart';
import '../../track/notifiers/track_notifier.dart';
import '../notifiers/favorite_tracks_notifier.dart';

class FavoriteTracksScreen extends ConsumerWidget {
  const FavoriteTracksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTrackState = ref.watch(favoriteTracksProvider);
    final colorScheme = Theme.of(context).colorScheme;

    return SafeArea(
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        appBar: AppBar(
          backgroundColor: colorScheme.primary,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          title: Text(
            'Tracciati Preferiti',
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: favoriteTrackState.when(
          data: (tracks) => ref
              .watch(fetchTracksByIdsProvider(tracks, context))
              .when(
                data: (tracksList) => Padding(
                  padding: EdgeInsets.all(16.r),
                  child: tracks.isNotEmpty
                      ? ListView.builder(
                          itemCount: tracksList.length,
                          itemBuilder: (context, index) {
                            final track = tracksList.elementAt(index);
                            return Container(
                              margin: EdgeInsets.only(bottom: 12.h),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.05),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Material(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(16),
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(16),
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => SafeArea(
                                          child: Scaffold(
                                            backgroundColor: colorScheme.surface,
                                            appBar: AppBar(
                                              backgroundColor: colorScheme.primary,
                                              foregroundColor: colorScheme.onPrimary,
                                              elevation: 0,
                                              title: Text(
                                                track.trackName,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            body: PanelWidget(
                                              track,
                                              hideDragHandle: true,
                                              scrollController: ScrollController(),
                                              panelController: PanelController(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  child: Padding(
                                    padding: EdgeInsets.all(16.r),
                                    child: Row(
                                      children: [
                                        // Track icon
                                        Container(
                                          padding: EdgeInsets.all(12.r),
                                          decoration: BoxDecoration(
                                            color: colorScheme.primary.withValues(alpha: 0.1),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          child: Icon(
                                            Icons.terrain_rounded,
                                            color: colorScheme.primary,
                                            size: 24.r,
                                          ),
                                        ),
                                        16.horizontalSpace,
                                        // Track info
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                track.trackName,
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: 15.sp,
                                                  color: colorScheme.onSurface,
                                                ),
                                              ),
                                              4.verticalSpace,
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.location_on_outlined,
                                                    size: 14.r,
                                                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                                                  ),
                                                  4.horizontalSpace,
                                                  Text(
                                                    track.region,
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 13.sp,
                                                      color: colorScheme.onSurface.withValues(alpha: 0.6),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        // Delete button
                                        IconButton(
                                          icon: Container(
                                            padding: EdgeInsets.all(8.r),
                                            decoration: BoxDecoration(
                                              color: colorScheme.error.withValues(alpha: 0.1),
                                              borderRadius: BorderRadius.circular(10),
                                            ),
                                            child: Icon(
                                              Icons.delete_outline_rounded,
                                              color: colorScheme.error,
                                              size: 20.r,
                                            ),
                                          ),
                                          onPressed: () {
                                            ref
                                                .read(favoriteTracksProvider.notifier)
                                                .removeTrack(track.id);
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  '${track.trackName} rimosso dai preferiti',
                                                  style: GoogleFonts.poppins(),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : _buildEmptyState(context, colorScheme),
                ),
                loading: () => Center(
                  child: CircularProgressIndicator(
                    color: colorScheme.primary,
                  ),
                ),
                error: (error, stackTrace) => _buildErrorState(context, colorScheme, error),
              ),
          loading: () => Center(
            child: CircularProgressIndicator(
              color: colorScheme.primary,
            ),
          ),
          error: (error, stackTrace) => _buildErrorState(context, colorScheme, error),
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context, ColorScheme colorScheme) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(24.r),
              decoration: BoxDecoration(
                color: colorScheme.primary.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.favorite_border_rounded,
                size: 64.r,
                color: colorScheme.primary,
              ),
            ),
            24.verticalSpace,
            Text(
              'Nessun preferito',
              style: GoogleFonts.poppins(
                fontSize: 20.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            8.verticalSpace,
            Text(
              'I tracciati che salvi come preferiti\nappariranno qui',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 14.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            24.verticalSpace,
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Tocca ',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
                Icon(
                  Icons.favorite_border_rounded,
                  size: 18.r,
                  color: colorScheme.primary,
                ),
                Text(
                  ' sulla mappa per salvare',
                  style: GoogleFonts.poppins(
                    fontSize: 13.sp,
                    color: colorScheme.onSurface.withValues(alpha: 0.5),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(BuildContext context, ColorScheme colorScheme, Object error) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(32.r),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline_rounded,
              size: 48.r,
              color: colorScheme.error,
            ),
            16.verticalSpace,
            Text(
              'Errore nel caricamento',
              style: GoogleFonts.poppins(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: colorScheme.onSurface,
              ),
            ),
            8.verticalSpace,
            Text(
              error.toString(),
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                fontSize: 13.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../views/components/dialogs/alert_dialog_model.dart';
import '../../../views/components/dialogs/remove_owned_track_dialog.dart';
import '../../../views/components/dialogs/remove_owner_privilege_dialog.dart';
import '../../track/models/track.dart';
import '../../track/notifiers/track_notifier.dart';
import '../notifiers/owned_tracks_notifier.dart';
import '../notifiers/user_state_notifier.dart';
import 'edit_track_screen.dart';

class OwnedTracksScreen extends ConsumerWidget {
  const OwnedTracksScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownedTrackState = ref.watch(ownedTracksProvider);
    final colorScheme = Theme.of(context).colorScheme;

    Future<void> shouldRemoveOwnerPrivilege(BuildContext context) async {
      final shouldRemovePrivilege = await const RemoveOwnerPrivilegeDialog()
          .present(context)
          .then((value) => value ?? false);
      if (shouldRemovePrivilege) {
        await ref.read(userStateProvider.notifier).makeUser();
        if (context.mounted) Navigator.of(context).pop();
      }
    }

    Future<void> shouldRemoveTrack(BuildContext context, Track track) async {
      final shouldRemovePrivilege = await const RemoveOwnedTrackDialog()
          .present(context)
          .then((value) => value ?? false);
      if (shouldRemovePrivilege) {
        await ref.read(ownedTracksProvider.notifier).removeTrack(track.id);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${track.trackName} rimosso dai tuoi posseduti'),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: colorScheme.surface,
      appBar: AppBar(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Tracciati Posseduti',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(20),
          ),
        ),
      ),
      body: SafeArea(
        child: ownedTrackState.when(
          data: (tracks) => ref
              .watch(fetchTracksByIdsProvider(tracks, context))
              .when(
                data: (tracksList) => tracksList.isNotEmpty
                    ? _buildTracksList(
                        context, tracksList, shouldRemoveTrack, colorScheme)
                    : _buildEmptyState(
                        context, shouldRemoveOwnerPrivilege, colorScheme),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) => _buildErrorState(error),
              ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stackTrace) => _buildErrorState(error),
        ),
      ),
    );
  }

  Widget _buildTracksList(
    BuildContext context,
    Iterable<Track> tracksList,
    Future<void> Function(BuildContext, Track) onRemove,
    ColorScheme colorScheme,
  ) {
    return ListView.builder(
      padding: EdgeInsets.all(16.r),
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
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => EditTrackScreen(track: track),
                  ),
                );
              },
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    // Track icon
                    Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            colorScheme.primary,
                            colorScheme.primary.withValues(alpha: 0.7),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Icon(
                        Icons.terrain_rounded,
                        color: Colors.white,
                        size: 24.r,
                      ),
                    ),
                    SizedBox(width: 14.w),
                    // Track info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            track.trackName,
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: colorScheme.onSurface,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14.r,
                                color: colorScheme.onSurface.withValues(alpha: 0.5),
                              ),
                              SizedBox(width: 4.w),
                              Flexible(
                                child: Text(
                                  track.region,
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Edit button
                    Container(
                      decoration: BoxDecoration(
                        color: colorScheme.primary.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.edit_rounded,
                          color: colorScheme.primary,
                          size: 20.r,
                        ),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => EditTrackScreen(track: track),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 8.w),
                    // Delete button
                    Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFEF4444).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        icon: Icon(
                          Icons.delete_outline_rounded,
                          color: const Color(0xFFEF4444),
                          size: 20.r,
                        ),
                        onPressed: () => onRemove(context, track),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(
    BuildContext context,
    Future<void> Function(BuildContext) onRemovePrivilege,
    ColorScheme colorScheme,
  ) {
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
                Icons.terrain_rounded,
                size: 60.r,
                color: colorScheme.primary,
              ),
            ),
            SizedBox(height: 24.h),
            Text(
              'Nessun tracciato',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.w700,
                color: colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Non hai ancora tracciati da gestire.',
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Puoi aggiungerne dalle impostazioni\nnella voce "Gestisci i tuoi tracciati"',
              style: TextStyle(
                fontSize: 14.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32.h),
            // Divider
            Container(
              width: 60.w,
              height: 2.h,
              decoration: BoxDecoration(
                color: colorScheme.onSurface.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(1),
              ),
            ),
            SizedBox(height: 32.h),
            Text(
              'Se non gestisci più tracciati,\npuoi rinunciare ai privilegi',
              style: TextStyle(
                fontSize: 13.sp,
                color: colorScheme.onSurface.withValues(alpha: 0.5),
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16.h),
            OutlinedButton.icon(
              onPressed: () => onRemovePrivilege(context),
              icon: const Icon(Icons.logout_rounded),
              label: const Text('Rinuncia a Gestione'),
              style: OutlinedButton.styleFrom(
                foregroundColor: const Color(0xFFEF4444),
                side: const BorderSide(color: Color(0xFFEF4444)),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorState(Object error) {
    return Center(
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
              'Errore',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFFEF4444),
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              error.toString(),
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

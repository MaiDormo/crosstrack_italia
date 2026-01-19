import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../map/providers/controller_utils.dart';
import '../models/track.dart';
import '../notifiers/track_notifier.dart';

class TrackCard extends ConsumerWidget {
  const TrackCard({
    super.key,
    required this.track,
    this.onTap,
    this.isCompact = false,
  });

  final Track track;
  final VoidCallback? onTap;
  final bool isCompact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelController = ref.watch(panelControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    void handleTap() {
      if (onTap != null) {
        onTap!();
      } else {
        ref.read(trackSelectedProvider.notifier).setTrack(track);
        panelController.isPanelClosed
            ? panelController.animatePanelToPosition(0.5)
            : panelController.close();
      }
    }

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isCompact ? 4.h : 6.h,
        horizontal: isCompact ? 8.w : 12.w,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: handleTap,
          child: Padding(
            padding: EdgeInsets.all(isCompact ? 12.r : 16.r),
            child: Row(
              children: [
                // Track icon container
                Container(
                  width: isCompact ? 44.r : 52.r,
                  height: isCompact ? 44.r : 52.r,
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
                    size: isCompact ? 22.r : 26.r,
                  ),
                ),
                SizedBox(width: 14.w),
                // Track info
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        track.trackName,
                        style: TextStyle(
                          fontSize: isCompact ? 14.sp : 16.sp,
                          fontWeight: FontWeight.w600,
                          color: colorScheme.onSurface,
                          letterSpacing: -0.3,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          _buildInfoChip(
                            context,
                            Icons.place_rounded,
                            track.region,
                            colorScheme.primary.withValues(alpha: 0.1),
                            colorScheme.primary,
                          ),
                        ],
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
                              track.location,
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: colorScheme.onSurface.withValues(alpha: 0.6),
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                // Rating badge
                if (track.rating > 0) ...[
                  SizedBox(width: 8.w),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getRatingColor(track.rating).withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_rounded,
                          size: 16.r,
                          color: _getRatingColor(track.rating),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          track.rating.toStringAsFixed(1),
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w600,
                            color: _getRatingColor(track.rating),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
                SizedBox(width: 4.w),
                Icon(
                  Icons.chevron_right_rounded,
                  color: colorScheme.onSurface.withValues(alpha: 0.3),
                  size: 24.r,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context,
    IconData icon,
    String label,
    Color backgroundColor,
    Color foregroundColor,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 12.r,
            color: foregroundColor,
          ),
          SizedBox(width: 4.w),
          Text(
            label,
            style: TextStyle(
              fontSize: 11.sp,
              fontWeight: FontWeight.w500,
              color: foregroundColor,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4.0) return const Color(0xFF4CAF50);
    if (rating >= 3.0) return const Color(0xFFFFA726);
    return const Color(0xFFEF5350);
  }
}

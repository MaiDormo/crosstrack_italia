import '../../../providers/controller_utils.dart';
import '../../../../track/models/track.dart';
import '../../../../track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class TrackMarkerPopup extends ConsumerWidget {
  const TrackMarkerPopup({
    super.key,
    required this.track,
  });
  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelController = ref.watch(panelControllerProvider);
    final colorScheme = Theme.of(context).colorScheme;

    Widget buildSkeletonScreenAnimation() => Shimmer(
          gradient: LinearGradient(
            colors: [
              colorScheme.surfaceContainerHighest,
              colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              colorScheme.surfaceContainerHighest,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: colorScheme.surface,
            ),
            height: 150.h,
            width: 200.w,
          ),
        );

    return Container(
      height: 150.h,
      width: 200.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () {
          ref.read(trackSelectedProvider.notifier).setTrack(track);
          panelController.isPanelClosed
              ? panelController.open()
              : panelController.close();
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              // Track thumbnail image
              Consumer(
                builder: (context, _, child) {
                  final image = ref.watch(trackThumbnailProvider(track));
                  return switch (image) {
                    AsyncData(:final value) => value,
                    AsyncError() => Image.asset(
                        'assets/images/placeholder.jpg',
                        fit: BoxFit.cover,
                      ),
                    _ => buildSkeletonScreenAnimation(),
                  };
                },
              ),
              // Gradient overlay for text readability
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 60.h,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.7),
                      ],
                    ),
                  ),
                ),
              ),
              // Track name
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Padding(
                  padding: EdgeInsets.all(12.r),
                  child: Text(
                    track.trackName,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                      fontSize: 12.sp,
                      shadows: [
                        Shadow(
                          color: Colors.black.withValues(alpha: 0.5),
                          blurRadius: 4,
                        ),
                      ],
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

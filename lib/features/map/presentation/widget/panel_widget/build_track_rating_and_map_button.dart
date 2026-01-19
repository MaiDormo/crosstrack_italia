import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackRatingAndMapButton(
  Track trackSelected,
  BuildContext context,
) =>
    Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        final colorScheme = Theme.of(context).colorScheme;
        
        return Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: colorScheme.primary.withValues(alpha: 0.05),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Rating section
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 10.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: _getRatingColor(trackSelected.rating),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.star_rounded,
                                size: 18.r,
                                color: Colors.white,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                trackSelected.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 15.sp,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 12.w),
                        RatingBarIndicator(
                          physics: const NeverScrollableScrollPhysics(),
                          itemSize: 18.r,
                          rating: trackSelected.rating,
                          direction: Axis.horizontal,
                          itemCount: 5,
                          itemBuilder: (context, _) => Icon(
                            Icons.star_rounded,
                            color: _getRatingColor(trackSelected.rating).withValues(alpha: 0.3),
                          ),
                          unratedColor: colorScheme.onSurface.withValues(alpha: 0.1),
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      '${trackSelected.commentCount} recensioni',
                      style: TextStyle(
                        fontSize: 13.sp,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.onSurface.withValues(alpha: 0.6),
                      ),
                    ),
                  ],
                ),
              ),
              // Directions button
              _buildDirectionsButton(trackSelected, context, ref),
            ],
          ),
        );
      },
    );

Widget _buildDirectionsButton(
  Track trackSelected,
  BuildContext context,
  WidgetRef ref,
) {
  final colorScheme = Theme.of(context).colorScheme;
  
  return Material(
    color: colorScheme.primary,
    borderRadius: BorderRadius.circular(14),
    child: InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () => ref
          .read(openGoogleMapProvider(trackSelected))
          .when(
            data: (value) => showSnackBar(
              context,
              value,
              'Apertura Google Maps in corso',
              'Google Maps non disponibile',
            ),
            loading: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Apertura Google Maps in corso'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
            error: (error, stackTrace) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Google Maps non disponibile'),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              );
            },
          ),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 12.h,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.directions_rounded,
              color: Colors.white,
              size: 20.r,
            ),
            SizedBox(width: 8.w),
            Text(
              'Indicazioni',
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

Color _getRatingColor(double rating) {
  if (rating >= 4.0) return const Color(0xFF10B981);
  if (rating >= 3.0) return const Color(0xFFF59E0B);
  return const Color(0xFFEF4444);
}

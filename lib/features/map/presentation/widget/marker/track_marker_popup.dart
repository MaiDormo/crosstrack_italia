import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

class TrackMarkerPopup extends ConsumerWidget {
  const TrackMarkerPopup({
    Key? key,
    required this.track,
  }) : super(key: key);
  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelController = ref.watch(panelControllerProvider);

    Widget buildSkeletonScreenAnimation() => Shimmer(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
              Theme.of(context).colorScheme.onSecondary,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
            height: 150.h,
            width: 200.w,
          ),
        );

    return Container(
      height: 150.h,
      width: 200.w,
      child: GestureDetector(
        onTap: () {
          ref.read(trackSelectedProvider.notifier).setTrack(track);
          panelController.isPanelClosed
              ? panelController.open()
              : panelController.close();
        },
        child: Stack(
          fit: StackFit.loose,
          alignment: Alignment.center,
          children: <Widget>[
            Consumer(
              builder: (context, _, child) {
                final image = ref.watch(trackThumbnailProvider(track));
                return Container(
                  height: 150.h,
                  width: 200.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: switch (image) {
                      AsyncData(:final value) => value,
                      AsyncError() => Image.asset(
                          'assets/images/placeholder.jpg',
                          fit: BoxFit.fill,
                        ),
                      _ => buildSkeletonScreenAnimation(),
                    },
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Container(
                  width: 170.w,
                  child: Text(
                    track.trackName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.onSecondary,
                      fontSize: 11.sp,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

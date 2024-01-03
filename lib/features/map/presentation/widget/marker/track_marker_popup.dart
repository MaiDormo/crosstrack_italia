import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrackMarkerPopup extends ConsumerWidget {
  const TrackMarkerPopup({
    Key? key,
    required this.track,
  }) : super(key: key);
  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelController = ref.watch(panelControllerProvider);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Theme.of(context).primaryColor,
      ),
      height: 150.h,
      width: 200.w,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: <Widget>[
          GestureDetector(
            child: Consumer(
              builder: (context, _, child) {
                final image = ref.watch(trackThumbnailProvider(track));
                return Container(
                  height: 150.h,
                  width: 200.w,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: image.when(
                      data: (image) {
                        return image;
                      },
                      loading: () {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        );
                      },
                      error: (error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.jpg',
                          fit: BoxFit.cover,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
            onTap: () {
              ref.read(trackSelectedProvider.notifier).setTrack(track);
              panelController.isPanelClosed
                  ? panelController.open()
                  : panelController.close();
            },
          ),
          Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Text(
              track.trackName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 11.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

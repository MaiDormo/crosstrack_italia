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
  });

  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelController = ref.watch(panelControllerProvider);
    return GestureDetector(
      onTap: () {
        ref.read(trackSelectedProvider.notifier).setTrack(track);
        panelController.isPanelClosed
            ? panelController
                .animatePanelToPosition(0.5) //50% of the open height
            : panelController.close();
        // Note: Search bar is now managed by Flutter's SearchAnchor
        // and closes automatically when a selection is made
      },
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16).w,
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      track.trackName,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    8.verticalSpace,
                    Row(
                      children: [
                        Icon(
                          Icons.flag,
                          size: 16.r,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        4.horizontalSpace,
                        Flexible(
                          // Wrap in Flexible to handle long text
                          child: Text(
                            track.region,
                            overflow:
                                TextOverflow.ellipsis, // Truncate with ellipsis
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.pin_drop,
                          size: 16.r,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        Flexible(
                          // Wrap in Flexible to handle long text
                          child: Text(
                            track.location,
                            overflow:
                                TextOverflow.ellipsis, // Truncate with ellipsis
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

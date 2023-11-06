import 'package:crosstrack_italia/features/map/providers/panel_controller_provider.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
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
    return SizedBox(
      width: 200,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              GestureDetector(
                child: Consumer(
                  builder: (context, _, child) {
                    final image = ref.watch(trackThumbnailProvider(track));
                    return image.when(
                      data: (image) {
                        return image;
                      },
                      loading: () {
                        return const CircularProgressIndicator();
                      },
                      error: (error, stackTrace) {
                        return Image.asset(
                          'assets/images/placeholder.jpg',
                          width: 200,
                          height: 100,
                          fit: BoxFit.cover,
                        );
                      },
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
              Text(track.trackName ?? 'No name'),
            ],
          ),
        ),
      ),
    );
  }
}

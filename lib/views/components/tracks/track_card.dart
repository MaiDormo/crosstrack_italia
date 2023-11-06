import 'package:crosstrack_italia/features/map/providers/floating_search_bar_controller_provider.dart';
import 'package:crosstrack_italia/features/map/providers/panel_controller_provider.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TrackCard extends ConsumerWidget {
  const TrackCard({
    super.key,
    required this.track,
  });

  final Track track;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final panelController = ref.watch(panelControllerProvider);
    final floatingSearchBarController =
        ref.watch(floatingSearchBarControllerProvider);
    return GestureDetector(
      onTap: () {
        ref.read(trackSelectedProvider.notifier).state = track;
        panelController.isPanelClosed
            ? panelController
                .animatePanelToPosition(0.5) //50% of the open height
            : panelController.close();
        floatingSearchBarController.close();
        //TODO: add a function to center the map on the selected track
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                track.trackName ?? 'No name',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.pin_drop,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Flexible(
                    // Wrap in Flexible to handle long text
                    child: Text(
                      track.region ?? 'No region',
                      overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const Spacer(),
                  Flexible(
                    // Wrap in Flexible to handle long text
                    child: Text(
                      track.location ?? 'No location',
                      overflow: TextOverflow.ellipsis, // Truncate with ellipsis
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

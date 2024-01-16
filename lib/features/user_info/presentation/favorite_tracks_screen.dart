import 'package:crosstrack_italia/features/map/presentation/panel_widget.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/favorite_tracks_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class FavoriteTracksScreen extends ConsumerWidget {
  const FavoriteTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteTrackState = ref.watch(favoriteTracksNotifierProvider);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Text('Tracciati Preferiti'),
        ),
        body: favoriteTrackState.when(
          data: (tracks) => ref
              .watch(fetchTracksByIdsProvider(tracks, context))
              .when(
                data: (tracksList) => Padding(
                  padding: const EdgeInsets.all(8.0).r,
                  child: tracks.isNotEmpty
                      ? ListView.builder(
                          itemCount: tracksList.length,
                          itemBuilder: (context, index) {
                            final track = tracksList.elementAt(index);
                            return Card(
                              color: Theme.of(context)
                                  .colorScheme
                                  .secondary, // same color as the ListTile
                              margin:
                                  const EdgeInsets.symmetric(vertical: 4.0).h,
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SafeArea(
                                              child: Scaffold(
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .primaryColor,
                                                appBar: AppBar(
                                                  backgroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .secondary,
                                                  foregroundColor:
                                                      Theme.of(context)
                                                          .colorScheme
                                                          .onSecondary,
                                                  shape:
                                                      const RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                      bottom:
                                                          Radius.circular(20),
                                                    ),
                                                  ),
                                                  title: Text(track.trackName),
                                                ),
                                                body: PanelWidget(
                                                  track,
                                                  hideDragHandle: true,
                                                  scrollController:
                                                      ScrollController(),
                                                  panelController:
                                                      PanelController(),
                                                ),
                                              ),
                                            )),
                                  );
                                },
                                child: ListTile(
                                  title: Material(
                                    type: MaterialType
                                        .transparency, // makes the child widget transparent
                                    child: Text(
                                      track.trackName,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  subtitle: Text(
                                    track.region,
                                    style: TextStyle(color: Colors.grey[400]),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(Icons.delete),
                                    color: Colors.red,
                                    onPressed: () {
                                      ref
                                          .read(favoriteTracksNotifierProvider
                                              .notifier)
                                          .removeTrack(track.id);
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              '${track.trackName} rimosso dai tuoi preferiti'),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.heart_broken,
                                size: 100.h,
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                              20.verticalSpace,
                              Text(
                                'Non hai tracciati preferiti',
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              ),
                              20.verticalSpace,
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'Selezionani dalla mappa cliccando: ',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSecondary,
                                    ),
                                  ),
                                  Icon(
                                    Icons.favorite_border,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                ),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(error.toString()),
                ),
              ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(error.toString()),
          ),
        ),
      ),
    );
  }
}

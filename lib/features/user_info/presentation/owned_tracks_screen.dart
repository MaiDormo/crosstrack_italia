import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/owned_tracks_notifier.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_state_notifier.dart';
import 'package:crosstrack_italia/features/user_info/presentation/edit_track_screen.dart';
import 'package:crosstrack_italia/views/components/dialogs/alert_dialog_model.dart';
import 'package:crosstrack_italia/views/components/dialogs/remove_owned_track_dialog.dart';
import 'package:crosstrack_italia/views/components/dialogs/remove_owner_privilege_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OwnedTracksScreen extends ConsumerWidget {
  const OwnedTracksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ownedTrackState = ref.watch(ownedTracksNotifierProvider);

    Future<void> shouldRemoveOwnerPrivilege(BuildContext context) async {
      final shouldRemovePrivilege = await const RemoveOwnerPrivilegeDialog()
          .present(context)
          .then((value) => value ?? false);
      if (shouldRemovePrivilege) {
        await ref.read(userStateNotifierProvider.notifier).makeUser();
        Navigator.of(context).pop();
      }
    }

    Future<void> shouldRemoveTrack(BuildContext context, Track track) async {
      final shouldRemovePrivilege = await const RemoveOwnedTrackDialog()
          .present(context)
          .then((value) => value ?? false);
      if (shouldRemovePrivilege) {
        await ref
            .read(ownedTracksNotifierProvider.notifier)
            .removeTrack(track.id);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${track.trackName} rimosso dai tuoi posseduti'),
          ),
        );
        ;
      }
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.secondary,
          foregroundColor: Theme.of(context).colorScheme.onSecondary,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          title: const Text('Tracciati Posseduti'),
        ),
        body: ownedTrackState.when(
          data: (tracks) => ref
              .watch(fetchTracksByIdsProvider(tracks, context))
              .when(
                data: (tracksList) => Padding(
                    padding: const EdgeInsets.all(8.0).r,
                    child: tracksList.isNotEmpty
                        ? ListView.builder(
                            itemCount: tracksList.length,
                            itemBuilder: (context, index) {
                              final track = tracksList.elementAt(index);
                              return GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditTrackScreen(
                                        track: track,
                                      ),
                                    ),
                                  );
                                },
                                child: Card(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .secondary, // same color as the ListTile
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 4.0)
                                          .h,
                                  child: ListTile(
                                    title: Material(
                                      type: MaterialType
                                          .transparency, // makes the child widget transparent
                                      child: Text(
                                        track.trackName,
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors
                                              .white, // same color as the ListTile text
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      track.region,
                                      style: TextStyle(
                                        color: Colors.grey[
                                            400], // adjust the color to match your app's theme
                                      ),
                                    ),
                                    trailing: IconButton(
                                      icon: const Icon(Icons.delete),
                                      color: Colors.red, // specify a color
                                      onPressed: () async {
                                        await shouldRemoveTrack(context, track);
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
                              children: [
                                Icon(
                                  Icons.warning,
                                  size: 100.sp,
                                  color: Colors.red,
                                ),
                                20.verticalSpace,
                                Text(
                                  'Non hai tracciati posseduti',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'Se lo ritieni un errore,',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'puoi uscire e rientrare dalla pagina attuale',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'Se non hai ancora tracciati posseduti,',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'puoi aggiungerne all\'interno delle',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'impostazioni nella voce:',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  '"Gestisci i tuoi tracciati"',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                20.verticalSpace,
                                Text(
                                  'Nel caso hai smesso di gestire tracciati,',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                Text(
                                  'premi il pulsante sottostante',
                                  style: TextStyle(
                                    fontSize: 13.sp,
                                    color:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                ),
                                20.verticalSpace,
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    foregroundColor:
                                        Theme.of(context).colorScheme.onPrimary,
                                  ),
                                  onPressed: () async {
                                    await shouldRemoveOwnerPrivilege(context);
                                  },
                                  child: const Text('Rinuncia a Gestione'),
                                ),
                              ],
                            ),
                          )),
                loading: () => const Center(
                  child: CircularProgressIndicator(),
                ),
                error: (error, stackTrace) => Center(
                  child: Text(
                    error.toString(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
          error: (error, stackTrace) => Center(
            child: Text(
              error.toString(),
              style: const TextStyle(color: Colors.red),
            ),
          ),
        ),
      ),
    );
  }
}

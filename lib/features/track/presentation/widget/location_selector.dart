import '../../../map/notifiers/user_location_notifier.dart';
import '../../../user_info/constants/user_constants.dart';
import '../../../user_info/notifiers/user_permission_notifier.dart';
import '../../../user_info/notifiers/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

class LocationSelector extends ConsumerWidget {
  const LocationSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final locationPermission = ref.watch(locationPermissionProvider);
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);
    final bool showMoreInfo =
        ref.watch(userSettingsProvider)[UserConstants.showMoreInfo]!;

    return locationPermission
        ? Padding(
            padding: const EdgeInsets.all(16.0).r,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                16.verticalSpace,
                Text(
                  'Condividi la tua posizione:',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                8.verticalSpace,
                ListTile(
                  title: const Text(
                    'Posizione: ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: showCurrentLocation
                      ? ref.watch(getLocationPlaceStringProvider).when(
                          data: (value) => Text(
                                value,
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSurface,
                                ),
                              ),
                          loading: () => buildSkeletonScreenAnimation(context),
                          error: (error, stackTrace) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    'Errore nel caricamento della posizione: $error'),
                              ),
                            );
                            return null;
                          })
                      : const Text(''),
                  trailing: Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: IconButton(
                      icon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                            visible: showMoreInfo,
                            child: Text(
                              showCurrentLocation ? 'Rimuovi' : 'Aggiungi',
                              style: TextStyle(
                                color:
                                    Theme.of(context).colorScheme.onSecondary,
                              ),
                            ),
                          ),
                          Icon(
                            showCurrentLocation
                                ? Icons.location_off
                                : Icons.location_on,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        if (showCurrentLocation) {
                          final confirm = await showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor:
                                  Theme.of(context).colorScheme.secondary,
                              title: const Text('Attenzione'),
                              content: const Text(
                                  'Sei sicuro di voler rimuovere la posizione?'),
                              actions: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: const Text('Annulla'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                ),
                                TextButton(
                                  style: TextButton.styleFrom(
                                    foregroundColor: Theme.of(context)
                                        .colorScheme
                                        .onSecondary,
                                    backgroundColor:
                                        Theme.of(context).colorScheme.secondary,
                                  ),
                                  child: const Text('Conferma'),
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                ),
                              ],
                            ),
                          );
                          if (confirm) {
                            ref
                                .read(showCurrentLocationProvider.notifier)
                                .toggle();
                          }
                        } else {
                          ref
                              .read(showCurrentLocationProvider.notifier)
                              .toggle();
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0).r,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Abilita la tua posizione per aggiungere informazioni: ',
                    style: TextStyle(
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  Card(
                    color: Theme.of(context).colorScheme.secondary,
                    child: IconButton(
                      icon: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Visibility(
                              visible: showMoreInfo,
                              child: Text(
                                'Abilita posizione',
                                style: TextStyle(
                                  color:
                                      Theme.of(context).colorScheme.onSecondary,
                                ),
                              )),
                          Icon(
                            Icons.location_on,
                            color: Theme.of(context).colorScheme.onSecondary,
                          ),
                        ],
                      ),
                      onPressed: () async {
                        await ref
                            .read(locationPermissionProvider.notifier)
                            .evaluateLocationPermission();
                        ref.read(showCurrentLocationProvider.notifier).toggle();
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

Widget buildSkeletonScreenAnimation(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0).w,
      child: Shimmer(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.onSecondary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.onSecondary,
          ],
          stops: const [0.0, 0.5, 1.0],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            width: 10.w,
            height: 15.h,
            color: Colors.white,
          ),
        ),
      ),
    );

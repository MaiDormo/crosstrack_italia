import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_permission_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LocationSelector extends ConsumerWidget {
  const LocationSelector({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final AsyncValue<bool> locationPermission =
        ref.watch(locationPermissionProvider);
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);
    return locationPermission.when(
      loading: () => Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => Center(
        child: Text(
          "Errore nel caricamento della posizione: $error",
          style: TextStyle(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
      ),
      data: (locationPermission) {
        return locationPermission
            ? Padding(
                padding: EdgeInsets.all(16.0).r,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    16.verticalSpace,
                    Text(
                      "Condividi la tua posizione:",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    8.verticalSpace,
                    ListTile(
                      title: Text(
                        "Posizione: ",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: showCurrentLocation
                          ? ref.watch(getLocationPlaceStringProvider).when(
                              data: (value) => Text(
                                    value,
                                    style: TextStyle(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
                                    ),
                                  ),
                              loading: () => const Center(
                                  child: CircularProgressIndicator()),
                              error: (error, stackTrace) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Errore nel caricamento della posizione: $error"),
                                  ),
                                );
                                return null;
                              })
                          : Text(""),
                      trailing: Tooltip(
                        message: showCurrentLocation
                            ? 'Disable location'
                            : 'Enable location',
                        child: IconButton(
                          icon: Icon(
                            showCurrentLocation
                                ? Icons.location_off
                                : Icons.location_on,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          onPressed: () async {
                            if (showCurrentLocation) {
                              final confirm = await showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  title: Text('Attenzione'),
                                  content: Text(
                                      'Sei sicuro di voler rimuovere la posizione?'),
                                  actions: [
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      child: Text('Annulla'),
                                      onPressed: () =>
                                          Navigator.of(context).pop(false),
                                    ),
                                    TextButton(
                                      style: TextButton.styleFrom(
                                        foregroundColor: Theme.of(context)
                                            .colorScheme
                                            .onSecondary,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .secondary,
                                      ),
                                      child: Text('Conferma'),
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
                  child: Text(
                    "Abilita la tua posizione per avere più informazioni",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              );
      },
    );
  }
}

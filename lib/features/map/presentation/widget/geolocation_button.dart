import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GeolocationButton extends ConsumerWidget {
  const GeolocationButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showCurrentLocation = ref.watch<bool>(showCurrentLocationProvider);
    final hasLocationPermission =
        ref.watch<bool>(hasLocationPermissionProvider);
    return IconButton(
      onPressed: () async {
        if (!hasLocationPermission) {
          await ref
              .read(hasLocationPermissionProvider.notifier)
              .getPermission();
        }
        ref.read(showCurrentLocationProvider.notifier).toggle();
      },
      icon: showCurrentLocation
          ? const Icon(Icons.gps_fixed)
          : const Icon(Icons.gps_not_fixed),
      color: Colors.red,
      iconSize: MediaQuery.of(context).size.width * 0.05,
    );
  }
}

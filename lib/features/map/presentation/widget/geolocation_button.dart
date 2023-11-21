import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GeolocationButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final showCurrentLocation = ref.watch<bool>(showCurrentLocationProvider);
    final locationServices = ref.watch<bool>(locationServicesProvider);

    return IconButton(
      onPressed: () {
        ref.read(showCurrentLocationProvider.notifier).toggle();
        if (!locationServices) {
          ref.read(showCurrentLocationProvider.notifier).toggle();
        }
      },
      icon: showCurrentLocation && locationServices
          ? const Icon(Icons.gps_fixed)
          : const Icon(Icons.gps_not_fixed),
      color: Colors.red,
      iconSize: MediaQuery.of(context).size.width * 0.05,
    );
  }
}

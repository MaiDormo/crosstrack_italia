import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_permission_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class GeolocationButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);
    final bool locationPermission = ref.watch(locationPermissionProvider);

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Theme.of(context).colorScheme.secondary,
      child: IconButton(
        onPressed: () async {
          if (!locationPermission) {
            await ref
                .read(locationPermissionProvider.notifier)
                .evaluateLocationPermission();
            ref.read(showCurrentLocationProvider.notifier).toggle();
          }

          if (locationPermission) {
            ref.read(showCurrentLocationProvider.notifier).toggle();
          }
        },
        icon: showCurrentLocation && locationPermission
            ? const Icon(Icons.gps_fixed)
            : const Icon(Icons.gps_not_fixed),
        color: Colors.red,
        iconSize: 20.6.w,
      ),
    );
  }
}

// onPressed: () async {
//                         await ref
//                             .read(locationPermissionProvider.notifier)
//                             .evaluateLocationPermission();
//                         ref.read(showCurrentLocationProvider.notifier).toggle();
//                       }

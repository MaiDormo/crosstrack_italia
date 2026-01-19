import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../user_info/notifiers/user_permission_notifier.dart';
import '../../notifiers/user_location_notifier.dart';

class GeolocationButton extends ConsumerWidget {
  const GeolocationButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bool showCurrentLocation = ref.watch(showCurrentLocationProvider);
    final bool locationPermission = ref.watch(locationPermissionProvider);
    final String? gpsError = ref.watch(gpsErrorProvider);

    // Show snackbar when GPS error occurs
    ref.listen<String?>(gpsErrorProvider, (previous, next) {
      if (next != null && previous == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(Icons.gps_off, color: Colors.white, size: 20.r),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    next,
                    style: TextStyle(fontSize: 14.sp),
                  ),
                ),
              ],
            ),
            backgroundColor: Theme.of(context).colorScheme.secondary,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            duration: const Duration(seconds: 4),
            action: SnackBarAction(
              label: 'OK',
              textColor: Colors.white,
              onPressed: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
            ),
          ),
        );
      }
    });

    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: gpsError != null 
          ? Colors.orange.shade700 
          : Theme.of(context).colorScheme.secondary,
      child: IconButton(
        onPressed: () async {
          debugPrint('📍 GPS Button pressed');
          debugPrint('📍 Current permission state: $locationPermission');
          debugPrint('📍 Current showLocation state: $showCurrentLocation');
          
          // Clear any previous error
          ref.read(gpsErrorProvider.notifier).clearError();
          
          if (!locationPermission) {
            debugPrint('📍 Requesting permission...');
            // Request permission first, then toggle if granted
            await ref
                .read(locationPermissionProvider.notifier)
                .evaluateLocationPermission();
            
            // Check if permission was granted after evaluation
            final granted = ref.read(locationPermissionProvider);
            debugPrint('📍 Permission granted: $granted');
            if (granted) {
              debugPrint('📍 Toggling location display...');
              ref.read(showCurrentLocationProvider.notifier).toggle();
            } else if (kIsWeb) {
              // Show a message on web when permission is denied
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Row(
                      children: [
                        Icon(Icons.location_off, color: Colors.white, size: 20.r),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: Text(
                            'Permesso GPS negato. Abilita la posizione nelle impostazioni del browser.',
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ),
                      ],
                    ),
                    backgroundColor: Colors.red.shade600,
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    duration: const Duration(seconds: 4),
                  ),
                );
              }
            }
          } else {
            // Already have permission, just toggle
            debugPrint('📍 Already have permission, toggling...');
            ref.read(showCurrentLocationProvider.notifier).toggle();
          }
          
          debugPrint('📍 Final showLocation state: ${ref.read(showCurrentLocationProvider)}');
        },
        icon: gpsError != null
            ? const Icon(Icons.gps_off)
            : showCurrentLocation && locationPermission
                ? const Icon(Icons.gps_fixed)
                : const Icon(Icons.gps_not_fixed),
        color: Colors.white,
        iconSize: 20.6.w,
      ),
    );
  }
}

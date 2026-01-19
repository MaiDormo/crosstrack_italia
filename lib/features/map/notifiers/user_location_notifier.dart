import 'package:flutter/foundation.dart' show kIsWeb, debugPrint;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../user_info/notifiers/user_permission_notifier.dart';
import '../constants/map_constants.dart';

part 'user_location_notifier.g.dart';

//------------------------PROVIDERS------------------------//

/// Tracks whether GPS is currently having errors (especially on web)
@Riverpod(keepAlive: true)
class GpsError extends _$GpsError {
  @override
  String? build() => null;

  void setError(String? error) {
    state = error;
  }

  void clearError() {
    state = null;
  }
}

@riverpod
Future<String> getLocationPlaceString(Ref ref) async {
  final userLocationNotifier = ref.watch(userLocationProvider.notifier);
  final locationPermission = ref.watch(locationPermissionProvider);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);

  return userLocationNotifier
      .getLocationPlaceString(locationPermission && showCurrentLocation);
}

@riverpod
Future<geo.Position?> getPosition(Ref ref) async {
  final locationPermission = ref.watch(locationPermissionProvider);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);

  final userLocationNotifier = ref.watch(userLocationProvider.notifier);
  final gpsErrorNotifier = ref.watch(gpsErrorProvider.notifier);

  if (!locationPermission || !showCurrentLocation) {
    return null;
  }
  
  try {
    final position = await userLocationNotifier.getPosition();
    gpsErrorNotifier.clearError();
    return position;
  } catch (e) {
    debugPrint('getPosition error: $e');
    // Set error state for UI to display
    if (kIsWeb) {
      gpsErrorNotifier.setError('GPS non disponibile sul browser. Prova su dispositivo mobile.');
    } else {
      gpsErrorNotifier.setError('Errore GPS: $e');
    }
    // Return null on error (especially for web where geolocation might fail)
    return null;
  }
}

//------------------------NOTIFIER------------------------//

//This is the notifier that will be used to toggle the showCurrentLocation bool
//and to display the correct icon in the geolocation button
@riverpod
class ShowCurrentLocation extends _$ShowCurrentLocation {
  @override
  bool build() => false;

  void toggle() {
    state = !state;
  }
}

//This is the notifier that will be used to center the map on the user location
@riverpod
class CenterUserLocation extends _$CenterUserLocation {
  @override
  AlignOnUpdate build() {
    return AlignOnUpdate.never;
  }

  void follow() {
    state = AlignOnUpdate.always;
  }

  void stopFollowing() {
    state = AlignOnUpdate.never;
  }
}

//This is the notifier that will be used to get the user location
@riverpod
class UserLocationNotifier extends _$UserLocationNotifier {
  @override
  void build() {}

  Future<String> getLocationPlaceString(bool canShow) async {
    if (canShow) {
      try {
        // First check if location service is enabled
        final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
        if (!serviceEnabled) {
          return MapConstants.errorLocation;
        }

        // Check permission
        final permission = await geo.Geolocator.checkPermission();
        if (permission == geo.LocationPermission.denied ||
            permission == geo.LocationPermission.deniedForever) {
          return MapConstants.errorLocation;
        }

        final location = await geo.Geolocator.getCurrentPosition(
          locationSettings: const geo.LocationSettings(
            accuracy: kIsWeb ? geo.LocationAccuracy.medium : geo.LocationAccuracy.high,
            // Web has longer timeouts
            timeLimit: Duration(seconds: kIsWeb ? 30 : 10),
          ),
        );
        final userLatitude = location.latitude;
        final userLongitude = location.longitude;

        // Geocoding doesn't work reliably on web
        if (kIsWeb) {
          return 'Lat: ${userLatitude.toStringAsFixed(4)}, Lon: ${userLongitude.toStringAsFixed(4)}';
        }

        final List<Placemark> placemarks = await placemarkFromCoordinates(
          userLatitude,
          userLongitude,
        );

        if (placemarks.isNotEmpty) {
          final Placemark closestPlacemark = placemarks.first;
          final String? closestLocation = closestPlacemark.locality ??
              closestPlacemark.subAdministrativeArea ??
              closestPlacemark.administrativeArea;
          return closestLocation ?? MapConstants.noLocationFound;
        }

        return MapConstants.noLocationFound;
      } catch (e) {
        debugPrint('getLocationPlaceString error: $e');
        return MapConstants.errorLocation;
      }
    } else {
      return MapConstants.initialLocation;
    }
  }

  Future<geo.Position> getPosition() async {
    try {
      // Check if location service is enabled
      final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        throw Exception('Location services are disabled');
      }

      // Check permission
      var permission = await geo.Geolocator.checkPermission();
      if (permission == geo.LocationPermission.denied) {
        permission = await geo.Geolocator.requestPermission();
        if (permission == geo.LocationPermission.denied) {
          throw Exception('Location permission denied');
        }
      }
      
      if (permission == geo.LocationPermission.deniedForever) {
        throw Exception('Location permission permanently denied');
      }

      final location = await geo.Geolocator.getCurrentPosition(
        locationSettings: const geo.LocationSettings(
          accuracy: kIsWeb ? geo.LocationAccuracy.medium : geo.LocationAccuracy.high,
          timeLimit: Duration(seconds: kIsWeb ? 30 : 10),
        ),
      );
      return location;
    } catch (e) {
      debugPrint('getPosition error: $e');
      rethrow;
    }
  }
}

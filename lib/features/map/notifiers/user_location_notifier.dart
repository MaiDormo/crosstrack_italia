import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_permission_notifier.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_notifier.g.dart';

//------------------------PROVIDERS------------------------//

@riverpod
Future<String> getLocationPlaceString(Ref ref) async {
  final userLocationNotifier = ref.watch(userLocationProvider.notifier);
  final locationPermission = ref.watch(locationPermissionProvider);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);

  return userLocationNotifier
      .getLocationPlaceString(locationPermission && showCurrentLocation);
}

@riverpod
Future<Position?> getPosition(Ref ref) async {
  final locationPermission = ref.watch(locationPermissionProvider);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);

  final userLocationNotifier = ref.watch(userLocationProvider.notifier);

  if (!locationPermission || !showCurrentLocation) {
    return null;
  }
  
  try {
    return await userLocationNotifier.getPosition();
  } catch (e) {
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
        final location = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.high,
            ));
        final userLatitude = location.latitude;
        final userLongitude = location.longitude;

        // Geocoding doesn't work reliably on web
        if (kIsWeb) {
          return 'Lat: ${userLatitude.toStringAsFixed(4)}, Lon: ${userLongitude.toStringAsFixed(4)}';
        }

        List<Placemark> placemarks = await placemarkFromCoordinates(
          userLatitude,
          userLongitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark closestPlacemark = placemarks.first;
          String? closestLocation = closestPlacemark.locality ??
              closestPlacemark.subAdministrativeArea ??
              closestPlacemark.administrativeArea;
          return closestLocation ?? MapConstants.noLocationFound;
        }

        return MapConstants.noLocationFound;
      } catch (e) {
        return MapConstants.errorLocation;
      }
    } else {
      return MapConstants.initialLocation;
    }
  }

  Future<Position> getPosition() async {
    try {
      final location = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high,
          )); // Get users location
      return location;
    } catch (e) {
      // Re-throw with more context for debugging
      throw Exception('Failed to get position: $e');
    }
  }
}

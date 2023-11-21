import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_notifier.g.dart';

//------------------------ENUM------------------------//

//------------------------PROVIDERS------------------------//

@riverpod
Future<String> getClosestLocation(GetClosestLocationRef ref) async {
  await ref.watch(locationServicesProvider.notifier).check();
  final userLocationNotifier = ref.watch(userLocationNotifierProvider.notifier);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);
  final locationServices = ref.watch(locationServicesProvider);
  return userLocationNotifier.getClosestLocation(
      showCurrentLocation, locationServices);
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

//This is the notifier that will be used to check if the user has location permission
//and to get the user location
@riverpod
class LocationServices extends _$LocationServices {
  @override
  bool build() => false;

  Future<void> check() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled.
      state = false;
    }

    // Check location permissions.
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next step is to ask the permissions from the user.
        state = false;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      state = false;
    }

    // When we reach here, location services are enabled and we have permission to use location.

    // Control the position stream
    var position = null;
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
    } catch (e) {}

    if (position != null) {
      state = true;
    } else {
      state = false;
    }
  }
}

//This is the notifier that will be used to center the map on the user location
@riverpod
class CenterUserLocation extends _$CenterUserLocation {
  @override
  FollowOnLocationUpdate build() {
    return FollowOnLocationUpdate.never;
  }

  void follow() {
    state = FollowOnLocationUpdate.always;
  }

  void stopFollowing() {
    state = FollowOnLocationUpdate.never;
  }
}

//This is the notifier that will be used to get the user location
@riverpod
class UserLocationNotifier extends _$UserLocationNotifier {
  @override
  bool build() => false;

  Future<String> getClosestLocation(
      bool showCurrentLocation, bool locationServices) async {
    if (showCurrentLocation && locationServices) {
      final location = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high); // Get users location
      final userLatitude = location.latitude;
      final userLongitude = location.longitude;
      List<Placemark> placemarks = await placemarkFromCoordinates(
          userLatitude, userLongitude,
          localeIdentifier: 'it_IT');
      if (placemarks.isNotEmpty) {
        Placemark closestPlacemark = placemarks.first;
        String? closestLocation = closestPlacemark.locality ??
            closestPlacemark.subAdministrativeArea ??
            closestPlacemark.administrativeArea;
        state = true;
        return closestLocation ?? MapConstans.noLocationFound;
        // Use the `closestLocation` string to display the closest main location to the user
      }
      state = false;
      return MapConstans.noLocationFound;
    } else {
      state = false;
      return MapConstans.initialLocation;
    }
  }
}

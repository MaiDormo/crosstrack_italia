import 'package:crosstrack_italia/features/map/providers/constants/map_constants.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_notifier.g.dart';

//------------------------ENUM------------------------//

//------------------------PROVIDERS------------------------//

@riverpod
Future<String> getClosestLocation(GetClosestLocationRef ref) async {
  final userLocationNotifier = ref.watch(userLocationNotifierProvider.notifier);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);
  final hasLocationPermission = ref.watch(hasLocationPermissionProvider);
  return userLocationNotifier.getClosestLocation(
      showCurrentLocation: showCurrentLocation,
      hasLocationPermission: hasLocationPermission);
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
class HasLocationPermission extends _$HasLocationPermission {
  @override
  bool build() => false;

  Future<void> getPermission() async {
    final permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      final permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        state = false;
      } else {
        state = true;
      }
    } else {
      state = true;
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

  Future<String> getClosestLocation({
    required bool showCurrentLocation,
    required bool hasLocationPermission,
  }) async {
    if (showCurrentLocation) {
      if (!hasLocationPermission) {
        await ref.read(hasLocationPermissionProvider.notifier).getPermission();
      }
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
        // state = true;
        return closestLocation ?? MapConstans.noLocationFound;
        // Use the `closestLocation` string to display the closest main location to the user
      }
      // state = false;
      return MapConstans.noLocationFound;
    } else {
      // state = false;
      return MapConstans.initialLocation;
    }
  }
}

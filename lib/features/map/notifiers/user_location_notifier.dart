import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_permission_notifier.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_location_notifier.g.dart';

//------------------------PROVIDERS------------------------//

@riverpod
Future<String> getLocationPlaceString(GetLocationPlaceStringRef ref) async {
  final userLocationNotifier = ref.watch(userLocationNotifierProvider.notifier);
  final locationPermission = ref.watch(locationPermissionProvider);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);

  // if (!locationPermission) {
  //   ref.read(locationPermissionProvider.notifier).evaluateLocationPermission();
  // }

  return userLocationNotifier
      .getLocationPlaceString(locationPermission && showCurrentLocation);
}

@riverpod
Future<Position?> getPosition(GetPositionRef ref) async {
  final locationPermission = ref.watch(locationPermissionProvider);
  final showCurrentLocation = ref.watch(showCurrentLocationProvider);

  final userLocationNotifier = ref.watch(userLocationNotifierProvider.notifier);

  // if (!locationPermission) {
  //   ref.read(locationPermissionProvider.notifier).evaluateLocationPermission();
  // }

  return locationPermission && showCurrentLocation
      ? await userLocationNotifier.getPosition()
      : null;
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
  void build() {}

  Future<String> getLocationPlaceString(bool canShow) async {
    if (canShow) {
      try {
        final location = await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high);
        final userLatitude = location.latitude;
        final userLongitude = location.longitude;

        List<Placemark> placemarks = await placemarkFromCoordinates(
            userLatitude, userLongitude,
            localeIdentifier: MapConstants.localeIdentifier);

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
    final location = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high); // Get users location
    return location;
  }
}

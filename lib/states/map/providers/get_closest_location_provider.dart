import 'package:crosstrack_italia/states/map/providers/show_current_location_provider.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'get_closest_location_provider.g.dart';

@riverpod
Future<String> getClosestLocation(GetClosestLocationRef ref) async {
  final showCurrentLocation = ref.watch<bool>(showCurrentLocationProvider);

  if (showCurrentLocation) {
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
      return closestLocation ?? 'Nessuna Località Trovata';
      // Use the `closestLocation` string to display the closest main location to the user
    }
    return 'Nessuna Località Trovata';
  } else {
    return 'Attivare la localizzazione';
  }
}

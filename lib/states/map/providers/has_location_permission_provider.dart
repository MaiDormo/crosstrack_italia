import 'package:crosstrack_italia/states/geolocator_permission/geolocator_permission.dart/geolocator_permission.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'has_location_permission_provider.g.dart';

@riverpod
class HasLocationPermission extends _$HasLocationPermission {
  @override
  bool build() => false;

  Future<void> checkPermission() async {
    try {
      determinePosition();
      state = true;
    } catch (e) {
      print(e as String);
      state = false;
    }
  }
}

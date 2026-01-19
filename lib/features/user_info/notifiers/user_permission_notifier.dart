import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:geolocator/geolocator.dart' as geo;
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_permission_notifier.g.dart';

@Riverpod(keepAlive: true)
class LocationPermission extends _$LocationPermission {
  @override
  bool build() => false;

  Future<void> evaluateLocationPermission() async {
    if (kIsWeb) {
      // On web, use Geolocator directly to check/request permission
      await _evaluateWebLocationPermission();
    } else {
      // On mobile, use permission_handler
      await _evaluateMobileLocationPermission();
    }
  }

  Future<void> _evaluateWebLocationPermission() async {
    try {
      // ignore: avoid_print
      print('🌐 Web: Checking location services...');
      
      // Check if location services are enabled
      final serviceEnabled = await geo.Geolocator.isLocationServiceEnabled();
      // ignore: avoid_print
      print('🌐 Web: Location services enabled: $serviceEnabled');
      
      if (!serviceEnabled) {
        // ignore: avoid_print
        print('🌐 Web: Location services are disabled');
        state = false;
        return;
      }

      // Check current permission status
      var permission = await geo.Geolocator.checkPermission();
      // ignore: avoid_print
      print('🌐 Web: Current permission status: $permission');
      
      if (permission == geo.LocationPermission.denied) {
        // ignore: avoid_print
        print('🌐 Web: Requesting permission...');
        // Request permission
        permission = await geo.Geolocator.requestPermission();
        // ignore: avoid_print
        print('🌐 Web: Permission after request: $permission');
      }

      // Update state based on permission result
      final granted = permission == geo.LocationPermission.whileInUse ||
              permission == geo.LocationPermission.always;
      // ignore: avoid_print
      print('🌐 Web: Permission granted: $granted');
      state = granted;
    } catch (e, stack) {
      // ignore: avoid_print
      print('🌐 Web location permission error: $e');
      // ignore: avoid_print
      print('🌐 Stack trace: $stack');
      state = false;
    }
  }

  Future<void> _evaluateMobileLocationPermission() async {
    final status = await Permission.location.request();
    state = switch (status) {
      PermissionStatus.granted => true,
      PermissionStatus.denied => false,
      PermissionStatus.limited => true,
      PermissionStatus.restricted => true,
      PermissionStatus.permanentlyDenied => false,
      _ => false,
    };
  }
}

@riverpod
class StoragePermission extends _$StoragePermission {
  @override
  Future<bool> build() async {
    if (kIsWeb) {
      // Storage permission not applicable on web
      return true;
    }
    return await Permission.storage.request().then((value) => switch (value) {
          PermissionStatus.granted => true,
          PermissionStatus.denied => false,
          PermissionStatus.limited => true,
          PermissionStatus.restricted => true,
          PermissionStatus.permanentlyDenied => false,
          _ => false,
        });
  }
}

@riverpod
class CameraPermission extends _$CameraPermission {
  @override
  Future<bool> build() async {
    if (kIsWeb) {
      // Camera permission handled differently on web
      return true;
    }
    return await Permission.camera.request().then((value) => switch (value) {
          PermissionStatus.granted => true,
          PermissionStatus.denied => false,
          PermissionStatus.limited => true,
          PermissionStatus.restricted => true,
          PermissionStatus.permanentlyDenied => false,
          _ => false,
        });
  }
}

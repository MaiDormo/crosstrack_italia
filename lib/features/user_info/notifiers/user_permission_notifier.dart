import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user_permission_notifier.g.dart';

@riverpod
class LocationPermission extends _$LocationPermission {
  @override
  bool build() => false;

  Future<void> evaluateLocationPermission() async {
    return await Permission.location.request().then((value) => switch (value) {
          PermissionStatus.granted => state = true,
          PermissionStatus.denied => state = false,
          PermissionStatus.limited => state = true,
          PermissionStatus.restricted => state = true,
          PermissionStatus.permanentlyDenied => state = false,
          _ => state = false,
        });
  }
}

@riverpod
class StoragePermission extends _$StoragePermission {
  @override
  Future<bool> build() async =>
      await Permission.storage.request().then((value) => switch (value) {
            PermissionStatus.granted => true,
            PermissionStatus.denied => false,
            PermissionStatus.limited => true,
            PermissionStatus.restricted => true,
            PermissionStatus.permanentlyDenied => false,
            _ => false,
          });
}

@riverpod
class CameraPermission extends _$CameraPermission {
  @override
  Future<bool> build() async =>
      await Permission.camera.request().then((value) => switch (value) {
            PermissionStatus.granted => true,
            PermissionStatus.denied => false,
            PermissionStatus.limited => true,
            PermissionStatus.restricted => true,
            PermissionStatus.permanentlyDenied => false,
            _ => false,
          });
}

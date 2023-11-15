import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'map_notifier.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  bool build() => false;

  void moveTo(LatLng position) {
    final mapController = ref.watch(mapControllerProvider);
    mapController.move(
      position,
      13.0,
    );
  }
}

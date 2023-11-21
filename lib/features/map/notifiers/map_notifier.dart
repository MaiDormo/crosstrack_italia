import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_map_animations/flutter_map_animations.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/scheduler.dart';

part 'map_notifier.g.dart';

@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  bool build() => false;

  void animateTo(LatLng position) {
    ref.read(animatedMapControllerProvider).animateTo(
          dest: position,
          zoom: 13.0,
        );
  }

  void animatedMoveTo(LatLng position) {}
}

@riverpod
VsyncContainer vsyncContainer(VsyncContainerRef ref) {
  return VsyncContainer();
}

@riverpod
TickerProvider vsync(VsyncRef ref) {
  return ref.watch(vsyncContainerProvider);
}

@riverpod
AnimatedMapController animatedMapController(AnimatedMapControllerRef ref) {
  final vsync = ref.watch(vsyncProvider);
  return AnimatedMapController(
    vsync: vsync,
    duration: const Duration(milliseconds: 500),
    curve: Curves.fastOutSlowIn,
  );
}

class VsyncContainer extends TickerProvider {
  late Ticker vsync;

  VsyncContainer() {
    vsync = createTicker((_) {});
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick, debugLabel: 'vsync');
  }
}

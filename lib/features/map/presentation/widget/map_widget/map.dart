import 'package:crosstrack_italia/features/map/models/regions.dart';
import 'package:crosstrack_italia/features/map/notifiers/map_notifier.dart';
import 'package:crosstrack_italia/features/map/notifiers/user_location_notifier.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/all_tracks_markers.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/lombardia_tracks_markers.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/trentino_alto_adige_tracks_markers.dart';
import 'package:crosstrack_italia/features/map/presentation/widget/marker/veneto_tracks_markers.dart';
import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:crosstrack_italia/features/map/providers/floating_searching_bar_utils.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_permission_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

class Map extends ConsumerStatefulWidget {
  const Map({
    Key? key,
  }) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends ConsumerState<Map> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _animatedMapController = ref.watch(animatedMapControllerProvider);
    final locationPermission = ref.watch(locationPermissionProvider);
    final showCurrentLocation = ref.watch(showCurrentLocationProvider);
    final centerUserLocation = ref.watch(centerUserLocationProvider);
    final selectedRegion = ref.watch(selectedRegionProvider);

    return FlutterMap(
      mapController: _animatedMapController.mapController,
      options: MapOptions(
        center: const LatLng(46.066775, 11.149904),
        zoom: 10.0,
        minZoom: 7.0,
        maxZoom: 18.0,
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        onTap: (tapPosition, position) {
          ref.read(panelControllerProvider).close();
          ref.read(popupControllerProvider).hideAllPopups();
        }, //close panel when tap on map
      ),
      nonRotatedChildren: [
        RichAttributionWidget(
          permanentHeight: 15.h,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
            ),
          ],
        ),
      ],
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.crosstrack_italia.app',
          tileProvider: FMTC.instance('mapStore').getTileProvider(),
        ),
        //contains layers
        //which themselves will contain all the makers
        locationPermission && showCurrentLocation
            ? CurrentLocationLayer(
                followOnLocationUpdate: centerUserLocation,
                turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                style: LocationMarkerStyle(
                  marker: DefaultLocationMarker(
                    color: Theme.of(context).colorScheme.secondary,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  markerSize: const Size.square(35),
                  showHeadingSector: false,
                ),
                // moveAnimationDuration: Duration.zero,
              )
            : const SizedBox.shrink(),

        Positioned(
          top: 90,
          right: 8,
          child: Padding(
            padding: const EdgeInsets.all(8.0).r,
            child: Visibility(
              visible: locationPermission,
              child: Opacity(
                opacity: showCurrentLocation ? 1 : 0.5,
                child: FloatingActionButton(
                  backgroundColor: showCurrentLocation
                      ? Theme.of(context).colorScheme.secondary
                      : Colors.grey[300],
                  onPressed: showCurrentLocation && locationPermission
                      ? () {
                          //wait for the map to center
                          ref
                              .read(centerUserLocationProvider.notifier)
                              .follow();
                          Future.delayed(const Duration(milliseconds: 500), () {
                            ref
                                .read(centerUserLocationProvider.notifier)
                                .stopFollowing();
                          });
                        }
                      : null,
                  child: const Icon(
                    Icons.my_location,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ),
        ),

        switch (selectedRegion) {
          Regions.all => const AllTracksMarkers(),
          Regions.veneto => const VenetoTracksMarkers(),
          Regions.lombardia => const LombardiaTracksMarkers(),
          Regions.trentinoAltoAdige => const TrentinoAltoAdigeTracksMarkers(),
        }
      ],
    );
  }
}

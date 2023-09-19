import 'package:crosstrack_italia/states/map/providers/center_user_location_provider.dart';
import 'package:crosstrack_italia/states/map/providers/has_location_permission_provider.dart';
import 'package:crosstrack_italia/states/map/providers/panel_controller_provider.dart';
import 'package:crosstrack_italia/states/map/providers/show_current_location_provider.dart';
import 'package:crosstrack_italia/views/components/markers/all_tracks_markers.dart';
import 'package:crosstrack_italia/views/components/markers/lombardia_tracks_markers.dart';
import 'package:crosstrack_italia/views/components/markers/trentino_alto_adige_tracks_markers.dart';
import 'package:crosstrack_italia/views/components/markers/veneto_tracks_markers.dart';
import 'package:crosstrack_italia/views/components/tracks/all_tracks_view.dart';
import 'package:crosstrack_italia/views/components/tracks/panel_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

final selectedRegionProvider = StateProvider<Choices>((ref) => Choices.all);
final mapController = MapController();
final panelController = PanelController();

enum Choices {
  all,
  veneto,
  lombardia,
  trentinoAltoAdige,
}

class MapScreenView extends ConsumerWidget {
  const MapScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final _panelHeightClosed = MediaQuery.of(context).size.height * 0.1;
    final _panelHeightOpen = MediaQuery.of(context).size.height * 0.6;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SlidingUpPanel(
        controller: ref.watch(panelControllerProvider),
        minHeight: _panelHeightClosed,
        maxHeight: _panelHeightOpen,
        parallaxEnabled: true,
        parallaxOffset: 0.5,
        color: Colors.orange.shade100,
        body: ClipRRect(
          borderRadius: const BorderRadius.all(
            Radius.circular(20),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Map(mapController: mapController),
              FloatingSearchMapBar(isPortrait: isPortrait),
            ],
          ),
        ),
        panelBuilder: (scrollController) => PanelWidget(
            scrollController: scrollController,
            panelController: panelController),
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
    );
  }
}

class Map extends ConsumerWidget {
  const Map({
    super.key,
    required this.mapController,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final centerUserLocation = ref.watch(centerUserLocationProvider);
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: const LatLng(46.066775, 11.149904),
        zoom: 10.0,
        minZoom: 7.0,
        maxZoom: 18.0, // consider setting maxNativeZoom per TileLayer instead,
        // to allow tiles to scale (and lose quality) on the final zoom level, instead of setting a hard limit.

        //maxBounds: Limits how far the map can be moved by the user to a coordinate-based boundary
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        onTap: (tapPosition, point) {},
        onPositionChanged: (position, hasGesture) {
          if (hasGesture &&
              centerUserLocation != FollowOnLocationUpdate.never) {
            ref.read(centerUserLocationProvider.notifier).state =
                FollowOnLocationUpdate.never;
          }
        },
        //keepAlive: true, in  order to keep the map from rebuilding in a nested widget tree (when out of sight)
      ),
      nonRotatedChildren: [
        RichAttributionWidget(
          permanentHeight: 15,
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
            ),
          ],
        ),
      ], //should not be used in order to keep the map in place
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.crosstrack_italia.app',
          tileProvider: FMTC.instance('mapStore').getTileProvider(),
        ),
        //contains layers
        //which themselves will contain all the makers

        Consumer(
          builder: (context, ref, child) {
            final hasLocationPermission =
                ref.watch<bool>(hasLocationPermissionProvider);
            final showCurrentLocation =
                ref.watch<bool>(showCurrentLocationProvider);
            final centerUserLocation = ref.watch(centerUserLocationProvider);
            if (showCurrentLocation && hasLocationPermission) {
              return CurrentLocationLayer(
                followOnLocationUpdate: centerUserLocation,
                turnOnHeadingUpdate: TurnOnHeadingUpdate.never,
                style: LocationMarkerStyle(
                  marker: const DefaultLocationMarker(
                    color: Colors.red,
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  markerSize: const Size.square(35),
                  accuracyCircleColor: Colors.red.withOpacity(0.1),
                  headingSectorColor: Colors.red.withOpacity(0.8),
                  headingSectorRadius: 120,
                ),
                // moveAnimationDuration: Duration.zero,
              );
            } else {
              return Container();
            }
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final showCurrentLocation = ref.watch(showCurrentLocationProvider);
            return Positioned(
              top: 90,
              right: 8,
              child: FloatingActionButton(
                backgroundColor: showCurrentLocation
                    ? Colors.black
                    : Colors.black.withOpacity(0.5),
                onPressed: showCurrentLocation
                    ? () {
                        ref.read(centerUserLocationProvider.notifier).state =
                            FollowOnLocationUpdate.always;
                      }
                    : null,
                child: const Icon(
                  Icons.my_location,
                  color: Colors.red,
                ),
              ),
            );
          },
        ),
        Consumer(
          builder: (context, ref, child) {
            final selectedRegion = ref.watch<Choices>(selectedRegionProvider);
            return switch (selectedRegion) {
              Choices.all => const AllTracksMarkers(),
              Choices.veneto => const VenetoTracksMarkers(),
              Choices.lombardia => const LombardiaTracksMarkers(),
              Choices.trentinoAltoAdige =>
                const TrentinoAltoAdigeTracksMarkers(),
            };
          },
        ),
        // Add cases for other regions
      ],
    );
  }
}

class FloatingSearchMapBar extends ConsumerWidget {
  const FloatingSearchMapBar({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FloatingSearchBar(
      hint: 'Search...',
      scrollPadding: const EdgeInsets.only(top: 16, bottom: 56),
      transitionDuration: const Duration(milliseconds: 800),
      transitionCurve: Curves.easeInOut,
      physics: const BouncingScrollPhysics(),
      axisAlignment: isPortrait ? 0.0 : -1.0,
      openAxisAlignment: 0.0,
      width: isPortrait ? 600 : 500,
      debounceDelay: const Duration(milliseconds: 500),
      onQueryChanged: (query) {
        // Call your model, bloc, controller here.
      },
      // Specify a custom transition to be used for
      // animating between opened and closed stated.
      transition: CircularFloatingSearchBarTransition(),
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,
        ),
        PopupMenuButton<Choices>(
          onSelected: (Choices result) {
            ref.read(selectedRegionProvider.notifier).state = result;
            LatLng center;
            switch (result) {
              case Choices.veneto:
                //pop current marker Layer
                center = const LatLng(
                    45.4384, 12.3272); // Replace with actual coordinates
                break;
              case Choices.lombardia:
                center = const LatLng(45.4384, 12.3272);
                break;
              case Choices.trentinoAltoAdige:
                center = const LatLng(45.4384, 12.3272);
                break;
              default:
                center = const LatLng(46.066775, 11.149904);
            }
            mapController.move(
                center, 8.0); // Center the map on the selected region
            // Update markers here based on the selected region
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry<Choices>>[
            const PopupMenuItem<Choices>(
              value: Choices.all,
              child: Text('All Regions'),
            ),
            const PopupMenuItem<Choices>(
              value: Choices.veneto,
              child: Text('Veneto'),
            ),
            // Add more PopupMenuItem entries for other regions
            const PopupMenuItem<Choices>(
              value: Choices.lombardia,
              child: Text('Lombardia'),
            ),
            const PopupMenuItem<Choices>(
              value: Choices.trentinoAltoAdige,
              child: Text('Trentino Alto Adige'),
            ),
          ],
        ),
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: const Material(
            color: Colors.white,
            elevation: 4.0,
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  AllTracksView(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

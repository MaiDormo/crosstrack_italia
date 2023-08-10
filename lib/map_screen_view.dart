import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart'; // Only import if required functionality is not exposed by default

class MapScreenView extends StatelessWidget {
  const MapScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mapController = MapController();
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Map(mapController: mapController),
            FloatingSearchMapBar(isPortrait: isPortrait),
          ],
        ),
      ),
    );
  }
}

class Map extends StatelessWidget {
  const Map({
    super.key,
    required this.mapController,
  });

  final MapController mapController;

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: mapController,
      options: MapOptions(
        center: const LatLng(46.066775, 11.149904),
        zoom: 15.0,
        minZoom: 10.0,
        maxZoom: 18.0, // consider setting maxNativeZoom per TileLayer instead,
        // to allow tiles to scale (and lose quality) on the final zoom level, instead of setting a hard limit.

        //maxBounds: Limits how far the map can be moved by the user to a coordinate-based boundary
        interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        //keepAlive: true, in  order to keep the map from rebuilding in a nested widget tree (when out of sight)
      ),
      nonRotatedChildren: const [], //should not be used in order to keep the map in place
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.crosstrack_italia.app',
        ),
        //contains layers
        //which themselves will contain all the makers
      ],
    );
  }
}

class FloatingSearchMapBar extends StatelessWidget {
  const FloatingSearchMapBar({
    super.key,
    required this.isPortrait,
  });

  final bool isPortrait;

  @override
  Widget build(BuildContext context) {
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
      ],
      builder: (context, transition) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20.0),
          child: Material(
            color: Colors.white,
            elevation: 4.0,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: Colors.accents.map((color) {
                return Container(height: 112, color: color);
              }).toList(),
            ),
          ),
        );
      },
    );
  }
}

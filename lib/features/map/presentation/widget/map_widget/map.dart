import 'dart:async';

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
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

// Conditional import for tile caching (not supported on web)
import 'tile_provider_stub.dart'
    if (dart.library.io) 'tile_provider_mobile.dart' as tile_provider;

class Map extends ConsumerStatefulWidget {
  const Map({
    Key? key,
  }) : super(key: key);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends ConsumerState<Map> with SingleTickerProviderStateMixin {
  StreamController<LocationMarkerPosition?>? _positionStreamController;
  Stream<LocationMarkerPosition?>? _positionStream;
  StreamSubscription<geo.Position>? _geolocatorSubscription;
  bool _isLocationActive = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _stopLocationStream();
    super.dispose();
  }

  void _stopLocationStream() {
    _geolocatorSubscription?.cancel();
    _geolocatorSubscription = null;
    _positionStreamController?.close();
    _positionStreamController = null;
    _positionStream = null;
    _isLocationActive = false;
  }

  /// Creates a position stream compatible with web and mobile
  void _startLocationStream() {
    if (_isLocationActive) return;
    
    debugPrint('🗺️ Starting position stream for ${kIsWeb ? "web" : "mobile"}');
    
    _positionStreamController = StreamController<LocationMarkerPosition?>.broadcast();
    _positionStream = _positionStreamController!.stream;
    _isLocationActive = true;

    if (kIsWeb) {
      // On web, get position once then poll periodically
      _startWebLocationPolling();
    } else {
      // On mobile, use the native stream
      _startMobileLocationStream();
    }
  }

  void _startWebLocationPolling() async {
    // Get initial position
    await _fetchAndEmitPosition();
    
    // Poll every 10 seconds on web
    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 10));
      if (!_isLocationActive || _positionStreamController == null) return false;
      await _fetchAndEmitPosition();
      return _isLocationActive;
    });
  }

  Future<void> _fetchAndEmitPosition() async {
    if (_positionStreamController == null || _positionStreamController!.isClosed) return;
    
    try {
      debugPrint('🗺️ Fetching position...');
      final position = await geo.Geolocator.getCurrentPosition(
        locationSettings: geo.LocationSettings(
          accuracy: kIsWeb ? geo.LocationAccuracy.medium : geo.LocationAccuracy.high,
          timeLimit: Duration(seconds: kIsWeb ? 15 : 10),
        ),
      );
      
      debugPrint('🗺️ Got position: ${position.latitude}, ${position.longitude}');
      
      // Clear any previous GPS error
      ref.read(gpsErrorProvider.notifier).clearError();
      
      if (_positionStreamController != null && !_positionStreamController!.isClosed) {
        _positionStreamController!.add(LocationMarkerPosition(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
        ));
      }
    } catch (e) {
      debugPrint('🗺️ Error fetching position: $e');
      // Set GPS error state for UI feedback
      if (kIsWeb) {
        ref.read(gpsErrorProvider.notifier).setError(
          'GPS non disponibile sul browser. Prova su dispositivo mobile.',
        );
      }
      // Don't add null on error, just skip this update
    }
  }

  void _startMobileLocationStream() {
    final locationSettings = const geo.LocationSettings(
      accuracy: geo.LocationAccuracy.high,
      distanceFilter: 5,
    );

    _geolocatorSubscription = geo.Geolocator.getPositionStream(
      locationSettings: locationSettings,
    ).listen(
      (position) {
        debugPrint('🗺️ Stream position: ${position.latitude}, ${position.longitude}');
        if (_positionStreamController != null && !_positionStreamController!.isClosed) {
          _positionStreamController!.add(LocationMarkerPosition(
            latitude: position.latitude,
            longitude: position.longitude,
            accuracy: position.accuracy,
          ));
        }
      },
      onError: (error) {
        debugPrint('🗺️ Position stream error: $error');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final _animatedMapController = ref.watch(animatedMapControllerProvider);
    final locationPermission = ref.watch(locationPermissionProvider);
    final showCurrentLocation = ref.watch(showCurrentLocationProvider);
    final centerUserLocation = ref.watch(centerUserLocationProvider);
    final selectedRegion = ref.watch(selectedRegionProvider);

    // Manage location stream based on state
    if (locationPermission && showCurrentLocation && !_isLocationActive) {
      _startLocationStream();
    } else if ((!showCurrentLocation || !locationPermission) && _isLocationActive) {
      _stopLocationStream();
    }

    return FlutterMap(
      mapController: _animatedMapController.mapController,
      options: MapOptions(
        initialCenter: const LatLng(46.066775, 11.149904),
        initialZoom: 10.0,
        minZoom: 7.0,
        maxZoom: 18.0,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.all & ~InteractiveFlag.rotate,
        ),
        onTap: (tapPosition, position) {
          ref.read(panelControllerProvider).close();
          ref.read(popupControllerProvider).hideAllPopups();
        }, //close panel when tap on map
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.crosstrack_italia.app',
          tileProvider: tile_provider.getTileProvider(),
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution(
              'OpenStreetMap contributors',
              textStyle: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 10.sp,
              ),
              onTap: () => launchUrl(
                Uri.parse('https://www.openstreetmap.org/copyright'),
              ),
            ),
          ],
        ),
        //contains layers
        //which themselves will contain all the makers
        if (locationPermission && showCurrentLocation && _positionStream != null)
          CurrentLocationLayer(
            positionStream: _positionStream,
            alignPositionOnUpdate: centerUserLocation,
            alignDirectionOnUpdate: AlignOnUpdate.never,
            style: LocationMarkerStyle(
              marker: DefaultLocationMarker(
                color: Theme.of(context).colorScheme.secondary,
                child: const Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
              markerSize: const Size.square(35),
              showHeadingSector: false,
            ),
          ),

        Positioned(
          top: 90.h,
          right: 8.w,
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
                  child: Icon(
                    showCurrentLocation && locationPermission
                        ? Icons.my_location
                        : Icons.location_disabled,
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

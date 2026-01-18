import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/map/models/regions.dart';
import 'package:crosstrack_italia/features/map/notifiers/map_notifier.dart';
import 'package:crosstrack_italia/features/map/providers/controller_utils.dart';
import 'package:crosstrack_italia/features/map/providers/floating_searching_bar_utils.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/track/presentation/track_card.dart';
import 'package:crosstrack_italia/features/track/providers/search_track_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:latlong2/latlong.dart';

/// A floating search bar for searching and filtering tracks on the map.
/// 
/// Uses Flutter's built-in SearchAnchor for cross-platform compatibility.
/// Provides:
/// - Track search functionality with real-time results
/// - Region filtering via popup menu
/// - Animated map navigation to selected tracks/regions
class FloatingSearchMapBar extends ConsumerStatefulWidget {
  const FloatingSearchMapBar({super.key});

  @override
  ConsumerState<FloatingSearchMapBar> createState() => _FloatingSearchMapBarState();
}

class _FloatingSearchMapBarState extends ConsumerState<FloatingSearchMapBar> {
  final SearchController _searchController = SearchController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onRegionSelected(Regions result) {
    final animatedMapController = ref.read(animatedMapControllerProvider);
    ref.read(selectedRegionProvider.notifier).setRegion(result);
    
    LatLng center;
    switch (result) {
      case Regions.veneto:
        center = MapConstants.venice;
        break;
      case Regions.lombardia:
        center = MapConstants.milan;
        break;
      case Regions.trentinoAltoAdige:
        center = MapConstants.trento;
        break;
      default:
        center = MapConstants.defaultLocation;
    }
    
    animatedMapController.animateTo(
      dest: center,
      zoom: MapConstants.defaultZoom,
    );
  }

  @override
  Widget build(BuildContext context) {
    final selectedRegion = ref.watch(selectedRegionProvider);

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      child: Row(
        children: [
          Expanded(
            child: SearchAnchor(
              searchController: _searchController,
              viewHintText: 'Cerca piste...',
              viewBackgroundColor: Theme.of(context).colorScheme.surface,
              viewSurfaceTintColor: Colors.transparent,
              headerHintStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
              headerTextStyle: TextStyle(
                color: Theme.of(context).colorScheme.onSurface,
              ),
              viewLeading: IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  _searchController.closeView(null);
                },
              ),
              builder: (BuildContext context, SearchController controller) {
                return SearchBar(
                  controller: controller,
                  hintText: 'Cerca...',
                  hintStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                  textStyle: WidgetStateProperty.all(
                    TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  backgroundColor: WidgetStateProperty.all(
                    Theme.of(context).colorScheme.onSecondary,
                  ),
                  elevation: WidgetStateProperty.all(2.0),
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  leading: Icon(
                    Icons.search,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                  onTap: () {
                    // Initialize search with all tracks when opening
                    final tracks = ref.read(fetchAllTracksProvider).whenOrNull(
                      data: (tracks) => tracks,
                    );
                    if (tracks != null) {
                      ref.read(searchTrackProvider.notifier).onSearchTrack('', tracks);
                    }
                    controller.openView();
                  },
                  onChanged: (_) {
                    controller.openView();
                  },
                );
              },
              viewBuilder: (Iterable<Widget> suggestions) {
                return Container(
                  color: Theme.of(context).colorScheme.primary,
                  child: ListView(
                    padding: EdgeInsets.all(8.r),
                    children: suggestions.toList(),
                  ),
                );
              },
              suggestionsBuilder: (BuildContext context, SearchController controller) {
                final query = controller.text.trim();
                
                // Get all tracks and filter
                final tracks = ref.read(fetchAllTracksProvider).whenOrNull(
                  data: (tracks) => tracks,
                ) ?? [];
                
                // Update search results
                ref.read(searchTrackProvider.notifier).onSearchTrack(query, tracks);
                
                // Get filtered results
                final filteredTracks = ref.read(searchTrackProvider);
                
                if (filteredTracks.isEmpty) {
                  return [
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        query.isEmpty 
                            ? 'Inizia a digitare per cercare...'
                            : 'Nessun risultato trovato',
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.onPrimary,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ];
                }
                
                return filteredTracks.map((track) => GestureDetector(
                  onTap: () {
                    controller.closeView(track.name);
                    
                    // Navigate to track on map
                    final animatedMapController = ref.read(animatedMapControllerProvider);
                    animatedMapController.animateTo(
                      dest: LatLng(track.latitude, track.longitude),
                      zoom: 14.0,
                    );
                    
                    // Open panel with track details
                    ref.read(panelControllerProvider).open();
                    ref.read(trackSelectedProvider.notifier).setTrack(track);
                  },
                  child: TrackCard(track: track),
                ));
              },
            ),
          ),
          SizedBox(width: 8.w),
          // Region filter button
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSecondary,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: PopupMenuButton<Regions>(
              elevation: 4.0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              icon: Tooltip(
                message: 'Filtra per regione',
                child: Icon(
                  Icons.filter_alt,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              color: Theme.of(context).colorScheme.onSecondary,
              onSelected: _onRegionSelected,
              itemBuilder: (BuildContext context) => <PopupMenuEntry<Regions>>[
                CheckedPopupMenuItem<Regions>(
                  value: Regions.all,
                  checked: selectedRegion == Regions.all,
                  child: Text(MapConstants.all),
                ),
                CheckedPopupMenuItem<Regions>(
                  value: Regions.veneto,
                  checked: selectedRegion == Regions.veneto,
                  child: Text(MapConstants.veneto),
                ),
                CheckedPopupMenuItem<Regions>(
                  value: Regions.lombardia,
                  checked: selectedRegion == Regions.lombardia,
                  child: Text(MapConstants.lombardia),
                ),
                CheckedPopupMenuItem<Regions>(
                  value: Regions.trentinoAltoAdige,
                  checked: selectedRegion == Regions.trentinoAltoAdige,
                  child: Text(MapConstants.trentinoAltoAdige),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

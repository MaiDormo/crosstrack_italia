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
    final colorScheme = Theme.of(context).colorScheme;

    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            left: 16.w,
            right: 16.w,
            top: 12.h,
          ),
          child: Row(
            children: [
              Expanded(
                child: SearchAnchor(
                  searchController: _searchController,
                  viewHintText: 'Cerca piste...',
                  viewBackgroundColor: colorScheme.surface,
                  viewSurfaceTintColor: Colors.transparent,
                  headerHintStyle: TextStyle(
                    color: colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                  headerTextStyle: TextStyle(
                    color: colorScheme.onSurface,
                  ),
                  viewLeading: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      _searchController.closeView(null);
                    },
                  ),
                  builder: (BuildContext context, SearchController controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.1),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: controller,
                        readOnly: true,
                        onTap: () {
                          final tracks = ref.read(fetchAllTracksProvider).whenOrNull(
                            data: (tracks) => tracks,
                          );
                          if (tracks != null) {
                            ref.read(searchTrackProvider.notifier).onSearchTrack('', tracks);
                          }
                          controller.openView();
                        },
                        decoration: InputDecoration(
                          hintText: 'Cerca piste...',
                          hintStyle: TextStyle(
                            color: colorScheme.onSurface.withValues(alpha: 0.5),
                            fontWeight: FontWeight.w400,
                          ),
                          prefixIcon: Icon(
                            Icons.search_rounded,
                            color: colorScheme.primary,
                          ),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 14.h,
                          ),
                        ),
                      ),
                    );
                  },
                  viewBuilder: (Iterable<Widget> suggestions) {
                    return Container(
                      color: colorScheme.surface,
                      child: ListView(
                        padding: EdgeInsets.all(8.r),
                        children: suggestions.toList(),
                      ),
                    );
                  },
                  suggestionsBuilder: (BuildContext context, SearchController controller) {
                    final query = controller.text.trim();
                    
                    final tracks = ref.read(fetchAllTracksProvider).whenOrNull(
                      data: (tracks) => tracks,
                    ) ?? [];
                    
                    ref.read(searchTrackProvider.notifier).onSearchTrack(query, tracks);
                    
                    final filteredTracks = ref.read(searchTrackProvider);
                    
                    if (filteredTracks.isEmpty) {
                      return [
                        Padding(
                          padding: EdgeInsets.all(24.r),
                          child: Column(
                            children: [
                              Icon(
                                query.isEmpty ? Icons.search_rounded : Icons.search_off_rounded,
                                size: 48.r,
                                color: colorScheme.onSurface.withValues(alpha: 0.3),
                              ),
                              SizedBox(height: 12.h),
                              Text(
                                query.isEmpty 
                                    ? 'Inizia a digitare per cercare...'
                                    : 'Nessun risultato trovato',
                                style: TextStyle(
                                  color: colorScheme.onSurface.withValues(alpha: 0.6),
                                  fontSize: 14.sp,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ];
                    }
                    
                    return filteredTracks.map((track) => TrackCard(
                      track: track,
                      onTap: () {
                        controller.closeView(track.trackName);
                        
                        final animatedMapController = ref.read(animatedMapControllerProvider);
                        final lat = double.tryParse(track.latitude) ?? 0.0;
                        final lng = double.tryParse(track.longitude) ?? 0.0;
                        animatedMapController.animateTo(
                          dest: LatLng(lat, lng),
                          zoom: 14.0,
                        );
                        
                        ref.read(panelControllerProvider).open();
                        ref.read(trackSelectedProvider.notifier).setTrack(track);
                      },
                    ));
                  },
                ),
              ),
              SizedBox(width: 12.w),
              // Region filter button
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: PopupMenuButton<Regions>(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  position: PopupMenuPosition.under,
                  icon: Icon(
                    Icons.tune_rounded,
                    color: colorScheme.primary,
                  ),
                  tooltip: 'Filtra per regione',
                  color: Colors.white,
                  onSelected: _onRegionSelected,
                  itemBuilder: (BuildContext context) => <PopupMenuEntry<Regions>>[
                    _buildRegionMenuItem(
                      Regions.all,
                      MapConstants.all,
                      Icons.public_rounded,
                      selectedRegion == Regions.all,
                      colorScheme,
                    ),
                    _buildRegionMenuItem(
                      Regions.veneto,
                      MapConstants.veneto,
                      Icons.place_rounded,
                      selectedRegion == Regions.veneto,
                      colorScheme,
                    ),
                    _buildRegionMenuItem(
                      Regions.lombardia,
                      MapConstants.lombardia,
                      Icons.place_rounded,
                      selectedRegion == Regions.lombardia,
                      colorScheme,
                    ),
                    _buildRegionMenuItem(
                      Regions.trentinoAltoAdige,
                      MapConstants.trentinoAltoAdige,
                      Icons.place_rounded,
                      selectedRegion == Regions.trentinoAltoAdige,
                      colorScheme,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PopupMenuItem<Regions> _buildRegionMenuItem(
    Regions region,
    String label,
    IconData icon,
    bool isSelected,
    ColorScheme colorScheme,
  ) {
    return PopupMenuItem<Regions>(
      value: region,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 4.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(8.r),
              decoration: BoxDecoration(
                color: isSelected 
                    ? colorScheme.primary.withValues(alpha: 0.1)
                    : Colors.grey.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                size: 20.r,
                color: isSelected ? colorScheme.primary : Colors.grey,
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                label,
                style: TextStyle(
                  color: isSelected ? colorScheme.primary : colorScheme.onSurface,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  fontSize: 14.sp,
                ),
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                size: 20.r,
                color: colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

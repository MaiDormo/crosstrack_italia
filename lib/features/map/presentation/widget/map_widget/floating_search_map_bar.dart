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
import 'package:material_floating_search_bar_2/material_floating_search_bar_2.dart';

class FloatingSearchMapBar extends ConsumerWidget {
  const FloatingSearchMapBar({
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = ref.watch(searchTrackProvider);
    final _animatedMapController = ref.watch(animatedMapControllerProvider);
    final selectedRegion = ref.watch(selectedRegionProvider);
    bool isLoading = false;
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: FloatingSearchBar(
        shadowColor: Colors.transparent,
        showCursor: true,
        borderRadius: BorderRadius.circular(20.0),
        backgroundColor: Theme.of(context).colorScheme.onSecondary,
        controller: ref.watch(floatingSearchBarControllerProvider),
        hint: 'Cerca...',
        hintStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
        ),
        queryStyle: TextStyle(
          color: Theme.of(context).colorScheme.secondary,
          fontWeight: FontWeight.normal,
        ),
        scrollPadding: EdgeInsets.only(top: 16.h, bottom: 56.h),
        transitionDuration: const Duration(milliseconds: 500),
        transitionCurve: Curves.easeInOut,
        physics: const BouncingScrollPhysics(),
        progress: isLoading,
        axisAlignment: 0.0,
        openAxisAlignment: 0.0,
        width: 600.w,
        debounceDelay: const Duration(milliseconds: 500),
        onFocusChanged: (isFocused) => isFocused == true
            ? ref.read(searchTrackProvider.notifier).onSearchTrack(
                '',
                ref.read(fetchAllTracksProvider).when(
                      data: (tracks) {
                        isLoading = false;
                        return tracks;
                      },
                      loading: () {
                        isLoading = true;
                        return {};
                      },
                      error: (error, stackTrace) {
                        isLoading = false;
                        return [];
                      },
                    ) ??
                    [])
            : null,
        onQueryChanged: (query) {
          ref.read(searchTrackProvider.notifier).onSearchTrack(
              query.trim(),
              ref.read(fetchAllTracksProvider).when(
                    data: (tracks) {
                      isLoading = false;
                      return tracks;
                    },
                    loading: () {
                      isLoading = true;
                      return [];
                    },
                    error: (error, stackTrace) {
                      isLoading = false;
                      return [];
                    },
                  ) ??
                  []);
        },
        transition: SlideFadeFloatingSearchBarTransition(),
        actions: [
          FloatingSearchBarAction.searchToClear(
            showIfClosed: false,
            color: Theme.of(context).colorScheme.secondary,
          ),
          PopupMenuButton<Regions>(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            icon: Tooltip(
              message: 'Filtra per regione',
              child: const Icon(Icons.filter_alt),
            ),
            color: Theme.of(context).colorScheme.onSecondary,
            iconColor: Theme.of(context).colorScheme.secondary,
            onSelected: (Regions result) {
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
              _animatedMapController.animateTo(
                dest: center,
                zoom: MapConstants.defaultZoom,
              ); // Center the map on the selected region
              // Update markers here based on the selected region
            },
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
              // Add more PopupMenuItem entries for other regions
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
        ],
        builder: (context, transition) {
          return ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Material(
              color: Theme.of(context).colorScheme.primary,
              elevation: 4.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0).r,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ...searchController.map(
                      (track) => TrackCard(track: track),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

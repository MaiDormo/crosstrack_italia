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
    bool isLoading = false;
    return Padding(
      padding: const EdgeInsets.all(8.0).r,
      child: FloatingSearchBar(
        shadowColor: Colors.transparent,
        showCursor: false,
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
            icon: const Icon(Icons.filter_alt),
            color: Theme.of(context).colorScheme.onSecondary,
            iconColor: Theme.of(context).colorScheme.secondary,
            onSelected: (Regions result) {
              ref.read(selectedRegionProvider.notifier).setRegion(result);
              LatLng center;
              switch (result) {
                case Regions.veneto:
                  center = MapConstans.venice;
                  break;
                case Regions.lombardia:
                  center = MapConstans.milan;
                  break;
                case Regions.trentinoAltoAdige:
                  center = MapConstans.trento;
                  break;
                default:
                  center = MapConstans.defaultLocation;
              }
              _animatedMapController.animateTo(
                dest: center,
                zoom: MapConstans.defaultZoom,
              ); // Center the map on the selected region
              // Update markers here based on the selected region
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<Regions>>[
              const PopupMenuItem<Regions>(
                value: Regions.all,
                child: Text(MapConstans.all),
              ),
              const PopupMenuItem<Regions>(
                value: Regions.veneto,
                child: Text(MapConstans.veneto),
              ),
              // Add more PopupMenuItem entries for other regions
              const PopupMenuItem<Regions>(
                value: Regions.lombardia,
                child: Text(MapConstans.lombardia),
              ),
              const PopupMenuItem<Regions>(
                value: Regions.trentinoAltoAdige,
                child: Text(MapConstans.trentinoAltoAdige),
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

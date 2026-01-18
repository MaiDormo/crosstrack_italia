/// Mobile tile provider with caching support.
/// Uses flutter_map_tile_caching for offline map support.
library;

import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

TileProvider getTileProvider() {
  return FMTCTileProvider(
    stores: const {'mapStore': BrowseStoreStrategy.readUpdateCreate},
  );
}

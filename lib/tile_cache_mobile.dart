/// Mobile implementation for tile caching.
/// Uses flutter_map_tile_caching for offline map support.
library;
import 'package:flutter_map_tile_caching/flutter_map_tile_caching.dart';

Future<void> initializeTileCache() async {
  await FMTCObjectBoxBackend().initialise();
  await const FMTCStore('mapStore').manage.create();
}

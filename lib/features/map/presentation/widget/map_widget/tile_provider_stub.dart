/// Stub tile provider for web platform.
/// Uses default network tile provider (no caching on web).
import 'package:flutter_map/flutter_map.dart';

TileProvider getTileProvider() {
  return NetworkTileProvider();
}

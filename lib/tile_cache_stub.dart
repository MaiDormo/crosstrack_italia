/// Stub implementation for web platform.
/// Tile caching is not supported on web (requires FFI/Isar).
Future<void> initializeTileCache() async {
  // No-op on web - tile caching not supported
}

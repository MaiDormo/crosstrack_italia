import 'package:flutter_map_location_marker/flutter_map_location_marker.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final centerUserLocationProvider =
    StateProvider<FollowOnLocationUpdate>((ref) => FollowOnLocationUpdate.once);

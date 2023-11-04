import 'package:crosstrack_italia/features/track_info/models/track.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final trackSelectedProvider = StateProvider.autoDispose<Track?>((ref) {
  return null;
});

import 'package:crosstrack_italia/states/track_info/models/track_info_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final trackSelectedProvider = StateProvider.autoDispose<TrackInfoModel?>((ref) {
  return null;
});

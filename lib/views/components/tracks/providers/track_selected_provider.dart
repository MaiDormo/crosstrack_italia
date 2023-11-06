import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'track_selected_provider.g.dart';

@riverpod
class TrackSelected extends _$TrackSelected {
  @override
  Track? build() {
    return null;
  }

  void setTrack(Track track) {
    state = track;
  }
}

import 'package:crosstrack_italia/features/map/models/regions.dart';
import 'package:crosstrack_italia/features/map/presentation/map_screen_view.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'floating_searching_bar_utils.g.dart';

@riverpod
class SelectedRegion extends _$SelectedRegion {
  @override
  Regions build() {
    return Regions.all;
  }

  void setRegion(Regions region) {
    state = region;
  }
}

// final searchTrackStringProvider = StateProvider<String>((ref) => '');
@riverpod
class SearchTrackString extends _$SearchTrackString {
  @override
  String build() {
    return '';
  }

  void setSearchTrackString(String searchTrackString) {
    state = searchTrackString;
  }
}

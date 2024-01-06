import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'search_track_provider.g.dart';

@riverpod
class SearchTrack extends _$SearchTrack {
  @override
  List<dynamic> build() {
    return [];
  }

  void onSearchTrack(String query, Iterable<dynamic> data) {
    state = [];
    if (query.isNotEmpty) {
      final result = data
          .where((element) => element.trackName
              .toString()
              .toLowerCase()
              .contains(query.toString().toLowerCase()))
          .toSet()
          .toList();
      state = result;
    } else {
      state = data.toList();
    }
  }
}

import 'package:crosstrack_italia/common/shared_preferences.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_tracks_notifier.g.dart';

@riverpod
class FavoriteTracksNotifier extends _$FavoriteTracksNotifier {
  late final SharedPreferences _sharedPreferences;
  @override
  List<TrackId> build() {
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
    return _initializeState();
  }

  void addFavorite(TrackId id) {
    state = [...state, id];
    _saveToSharedPreferences();
  }

  void removeFavorite(TrackId id) {
    state = state.where((_id) => _id != id).toList();
    _saveToSharedPreferences();
  }

  void _saveToSharedPreferences() {
    final sharedPreferences = ref.watch(sharedPreferencesProvider);
    sharedPreferences.setStringList(
      'favoriteTracks',
      state,
    );
  }

  List<TrackId> _initializeState() {
    final savedTracks = _sharedPreferences.getStringList('favoriteTracks');
    return savedTracks != null ? state = savedTracks : state = [];
  }

  //upload to firebase
  //download from firebase
}

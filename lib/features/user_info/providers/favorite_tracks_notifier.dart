import 'package:crosstrack_italia/common/shared_preferences.dart';
import 'package:crosstrack_italia/features/auth/notifiers/auth_state_notifier.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'favorite_tracks_notifier.g.dart';

@riverpod
class FavoriteTracksNotifier extends _$FavoriteTracksNotifier {
  late final SharedPreferences _sharedPreferences;
  late final _authStateNotifier;
  @override
  Future<List<TrackId>> build() async {
    _sharedPreferences = ref.watch(sharedPreferencesProvider);
    _authStateNotifier = ref.watch(authStateNotifierProvider.notifier);
    final _isLoggedIn = ref.watch(isLoggedInProvider);
    print('DEBUG FAVORITE TRACKS: STARTING BUILD');
    if (_isLoggedIn) {
      return _initializeStateFromFirebase();
    } else {
      print('DEBUG FAVORITE TRACKS: USER NOT LOGGED IN');
      return _initializeStateFromSharedPreferences();
    }
  }

  Future<void> addFavorite(TrackId id) async {
    final AsyncData<List<TrackId>> _state = switch (state) {
      AsyncData(:final value) => AsyncData([...value, id]),
      _ => AsyncData([id]),
    };
    state = _state;
    _saveToSharedPreferences();
  }

  Future<void> removeFavorite(TrackId id) async {
    final AsyncData<List<TrackId>> _state = switch (state) {
      AsyncData(:final value) =>
        AsyncData(value.where((e) => e != id).toList()),
      _ => AsyncData([]),
    };
    state = _state;
    _saveToSharedPreferences();
  }

  Future<void> _saveToSharedPreferences() async {
    final List<TrackId> _state = switch (state) {
      AsyncData(:final value) => value,
      _ => [],
    };
    state = AsyncLoading();
    await _sharedPreferences.setStringList(
      'favoriteTracks',
      _state,
    );
    state = AsyncData(_state);
  }

  Future<List<TrackId>> _initializeStateFromFirebase() async {
    await reset();
    final List<TrackId> _firebaseTracks =
        await _authStateNotifier.fetchFavoriteTracks();
    return _firebaseTracks;
  }

  List<TrackId> _initializeStateFromSharedPreferences() {
    final _favoriteTracks = _sharedPreferences.getStringList('favoriteTracks');
    if (_favoriteTracks != null) {
      return _favoriteTracks;
    } else {
      return [];
    }
  }

  Future<void> saveToFirebase() async {
    final _id = ref.watch(userIdProvider);
    final _isLoggedIn = ref.watch(isLoggedInProvider);
    final List<TrackId> _state = switch (state) {
      AsyncData(:final value) => value,
      _ => [],
    };
    print('DEBUG FAVORITE TRACKS: STARTING SAVE TO FIREBASE');
    print('DEBUG FAVORITE TRACKS: SAVING $_state');
    if (_isLoggedIn) {
      print('DEBUG FAVORITE TRACKS: USER LOGGED IN: ' +
          _id.toString() +
          ', SAVING TO FIREBASE');
      await _authStateNotifier.saveUserInfo(
        id: _id,
        favoriteTracks: _state,
      );
      print('DEBUG FAVORITE TRACKS: SAVED TO FIREBASE');
    }
    print('DEBUG FAVORITE TRACKS: SAVING TO SHARED PREFERENCES');
    state = AsyncData(_state);
  }

  //reset shared preferences
  Future<void> reset() async {
    print('DEBUG FAVORITE TRACKS: STARTING RESET SHARED PREFERENCES');
    await _sharedPreferences.remove('favoriteTracks');
    print('DEBUG FAVORITE TRACKS: FINISHED SHARED PREFERENCES RESET');
  }
}

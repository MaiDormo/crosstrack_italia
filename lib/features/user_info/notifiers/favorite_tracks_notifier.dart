import 'package:crosstrack_italia/features/user_info/providers/user_info_providers.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/backend/favorite_tracks_repository.dart';
import 'package:crosstrack_italia/firebase_providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_tracks_notifier.g.dart';

@riverpod
FavoriteTracksRepository favoriteTracksRepository(Ref ref) {
  final _firestore = ref.watch(firestoreProvider);
  final _userId = ref.watch(userIdProvider);
  final _isLogged = ref.watch(isLoggedInProvider);
  return _isLogged
      ? FirebaseFavoriteTracksRepository(firestore: _firestore, userId: _userId)
      : SharedPrefsFavoriteTracksRepository();
}

@riverpod
class FavoriteTracksNotifier extends _$FavoriteTracksNotifier {
  late FavoriteTracksRepository _service;

  @override
  Future<List<TrackId>> build() async {
    _service = ref.watch(favoriteTracksRepositoryProvider);
    return await _service.getFavoriteTracks();
  }

  Future<void> addTrack(TrackId trackId) async {
    await _service.addTrack(trackId);
    state = AsyncData(await _service.getFavoriteTracks());
  }

  Future<void> removeTrack(TrackId trackId) async {
    await _service.removeTrack(trackId);
    state = AsyncData(await _service.getFavoriteTracks());
  }

  Future<void> fetchFavoriteTracks() async {
    state = AsyncData(await _service.getFavoriteTracks());
  }
}

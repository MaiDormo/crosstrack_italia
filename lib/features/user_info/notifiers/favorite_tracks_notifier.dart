import '../providers/user_info_providers.dart';
import '../../track/models/typedefs/typedefs.dart';
import '../backend/favorite_tracks_repository.dart';
import '../../../firebase_providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_tracks_notifier.g.dart';

@riverpod
FavoriteTracksRepository favoriteTracksRepository(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  final userId = ref.watch(userIdProvider);
  final isLogged = ref.watch(isLoggedInProvider);
  return isLogged
      ? FirebaseFavoriteTracksRepository(firestore: firestore, userId: userId)
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

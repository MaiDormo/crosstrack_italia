import '../providers/user_info_providers.dart';
import '../../track/models/track.dart';
import '../../track/models/typedefs/typedefs.dart';
import '../backend/owned_tracks_repository.dart';
import '../../../firebase_providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owned_tracks_notifier.g.dart';

@riverpod
OwnedTracksRepository ownedTracksRepository(Ref ref) {
  final firestore = ref.watch(firestoreProvider);
  final userId = ref.watch(userIdProvider);
  return OwnedTracksRepository(firestore: firestore, userId: userId);
}

@riverpod
class OwnedTracksNotifier extends _$OwnedTracksNotifier {
  late final OwnedTracksRepository _service;

  @override
  Future<List<TrackId>> build() async {
    _service = ref.watch(ownedTracksRepositoryProvider);
    return await _service.getOwnedTracks();
  }

  Future<void> addTracks(List<TrackId> trackIds) async {
    await _service.addTracks(trackIds);
    // Check if still mounted before updating state
    if (!ref.mounted) return;
    state = AsyncData(await _service.getOwnedTracks());
  }

  Future<void> removeTrack(TrackId trackId) async {
    await _service.removeTrack(trackId);
    // Check if still mounted before updating state
    if (!ref.mounted) return;
    state = AsyncData(await _service.getOwnedTracks());
  }

  Future<void> fetchOwnedTracks() async {
    // Check if still mounted before updating state
    if (!ref.mounted) return;
    state = AsyncData(await _service.getOwnedTracks());
  }

  Future<void> updateTrackInfo(Track track) async {
    await _service.updateTrackInfo(track);
    // Check if still mounted before updating state
    if (!ref.mounted) return;
    state = AsyncData(await _service.getOwnedTracks());
  }
}

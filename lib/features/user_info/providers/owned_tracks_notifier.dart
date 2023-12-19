import 'package:crosstrack_italia/features/auth/providers/auth_providers.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/features/user_info/models/owned_tracks_service.dart';
import 'package:crosstrack_italia/providers/firebase_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'owned_tracks_notifier.g.dart';

@riverpod
OwnedTracksService ownedTracksService(OwnedTracksServiceRef ref) {
  final _firestore = ref.watch(firestoreProvider);
  final _userId = ref.watch(userIdProvider)!;
  return OwnedTracksService(firestore: _firestore, userId: _userId);
}

@riverpod
class OwnedTracksNotifier extends _$OwnedTracksNotifier {
  late final OwnedTracksService _service;

  @override
  Future<List<TrackId>> build() async {
    _service = ref.watch(ownedTracksServiceProvider);
    return await _service.getOwnedTracks();
  }

  Future<void> addTrack(TrackId trackId) async {
    await _service.addTrack(trackId);
    state = AsyncData(await _service.getOwnedTracks());
  }

  Future<void> removeTrack(TrackId trackId) async {
    await _service.removeTrack(trackId);
    state = AsyncData(await _service.getOwnedTracks());
  }

  Future<void> fetchOwnedTracks() async {
    state = AsyncData(await _service.getOwnedTracks());
  }
}

import 'dart:async';
import 'package:crosstrack_italia/common/utils.dart';
import 'package:crosstrack_italia/features/auth/providers/user_id_provider.dart';
import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/map/notifiers/map_notifier.dart';
import 'package:crosstrack_italia/features/track/backend/track_repository.dart';
import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/providers/storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'track_notifier.g.dart';

//idea is to have a notifier that contains all of the necessary function related
//to the track repository, and then create a provider for every single function
//inside of the notifier that needs to ouput data to the UI

//------------------PROVIDERS------------------//
@riverpod
Stream<Iterable<Track>> fetchAllTracks(FetchAllTracksRef ref) {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  return trackNotifier.fetchAllTracks();
}

@riverpod
Stream<Iterable<Track>> fetchTracksByRegion(
    FetchTracksByRegionRef ref, String region) async* {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  yield* trackNotifier.fetchTracksByRegion(region);
}

@riverpod
Future<Image> trackThumbnail(TrackThumbnailRef ref, Track track) async {
  final trackNotifier = await ref.watch(trackNotifierProvider.notifier);
  final image = await trackNotifier.trackThumbnail(track);
  return image;
}

@riverpod
Stream<Iterable<Image>> allTrackImages(AllTrackImagesRef ref) async* {
  final track = ref.watch(trackSelectedProvider);
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  yield* trackNotifier.allTrackImages(track);
}

@riverpod
Stream<Iterable<Comment>> fetchCommentsByTrackId(
    FetchCommentsByTrackIdRef ref, TrackId trackId) async* {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  yield* trackNotifier.fetchCommentsByTrackId(trackId);
}

//------------------NOTIFIER------------------//

@riverpod
class TrackSelected extends _$TrackSelected {
  @override
  Track? build() {
    return null;
  }

  void setTrack(Track track) {
    state = track;

    ref.read(mapNotifierProvider.notifier).animateTo(
          LatLng(
            double.parse(track.latitude),
            double.parse(track.longitude),
          ),
        );
  }
}

@riverpod
class TrackNotifier extends _$TrackNotifier {
  late final TrackRepository _trackRepository;
  late final StorageRepository _storageRepository;

  @override
  bool build() {
    _trackRepository = ref.watch(trackRepositoryProvider);
    _storageRepository = ref.watch(storageRepositoryProvider);
    return false;
  }

  //get all tracks
  Stream<Iterable<Track>> fetchAllTracks() async* {
    //counting on the fact that there are always tracks inside the db
    yield* _trackRepository.fetchAllTracks();
  }

  //get tracks by region
  Stream<Iterable<Track>> fetchTracksByRegion(String region) async* {
    yield* _trackRepository.fetchTracksByRegion(region);
  }

  //collect track Thumbnail
  Future<Image> trackThumbnail(Track track) async {
    try {
      final imageUrl = await _storageRepository
          .getDownloadUrl(track.photosUrl + MapConstans.thumbnail);
      final image = Image.network(
        imageUrl,
        width: 300,
        height: 120,
        fit: BoxFit.cover,
        scale: MapConstans.scaleImage,
      );
      state = true;

      return image;
    } catch (e) {
      state = false;
      return Image.asset(
        MapConstans.placeholder,
        width: 300,
        height: 150,
        fit: BoxFit.cover,
        scale: MapConstans.scaleImage,
      );
    }
  }

  //collect all images related to a single track
  Stream<Iterable<Image>> allTrackImages(Track? track) async* {
    final controller = StreamController<Iterable<Image>>();
    //get all images inside the tracks/{track.region}/{track.trackWebCode}/
    if (track != null) {
      final storageRegion = track.region?.toLowerCase().replaceAll(' ', '_');
      final path = 'tracks/${storageRegion}/${track.trackWebCode}/';
      final urls = await _storageRepository.listDownloadUrl(path);
      final imagesList = await urls.map((e) => Image.network(e));
      controller.add(imagesList);
      state = true;
    } else {
      state = false;
      controller.add([]);
    }
    yield* controller.stream;
  }

  //add comment
  void addComment(
    BuildContext context,
    String text,
    TrackId trackId,
  ) async {
    final String commentId = Uuid().v1();
    final userId = ref.read(userIdProvider)!;
    final Comment comment = Comment(
      commentId: commentId,
      trackId: trackId,
      userId: userId,
      userName: FirebaseAuth.instance.currentUser!.displayName!,
      text: text,
      date: DateTime.now(),
    );

    final res = await _trackRepository.addComment(comment);

    ///TODO: do something with the user
    res.fold((l) => showSnackBar(context, l.message), (r) => null);
  }

  //get all comments related to a track
  Stream<Iterable<Comment>> fetchCommentsByTrackId(TrackId trackId) async* {
    yield* _trackRepository.fetchCommentsByTrackId(trackId);
  }
}

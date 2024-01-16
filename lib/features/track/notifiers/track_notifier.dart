import 'dart:async';
import 'package:crosstrack_italia/common/utils.dart';
import 'package:crosstrack_italia/features/user_info/providers/user_info_providers.dart';
import 'package:crosstrack_italia/features/map/constants/map_constants.dart';
import 'package:crosstrack_italia/features/map/notifiers/map_notifier.dart';
import 'package:crosstrack_italia/features/track/backend/track_repository.dart';
import 'package:crosstrack_italia/features/track/models/comment.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:crosstrack_italia/firebase_providers/storage_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'package:url_launcher/url_launcher.dart';

part 'track_notifier.g.dart';

//idea is to have a notifier that contains all of the necessary function related
//to the track repository, and then create a provider for every single function
//inside of the notifier that needs to ouput data to the UI

//------------------PROVIDERS------------------//
@riverpod
Stream<Iterable<Track>> fetchAllTracks(FetchAllTracksRef ref) {
  print('DEBUG rebuild fetchAllTracks');
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
Future<List<Widget>> fetchSelectedTracksThumbnail(
    FetchSelectedTracksThumbnailRef ref, List<Track> tracks) async {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  final images = await trackNotifier.fetchSelectedTracksThumbnail(tracks);
  return images;
}

@riverpod
Future<Widget> trackThumbnail(TrackThumbnailRef ref, Track track) async {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  final image = await trackNotifier.trackThumbnail(track);
  return image;
}

@riverpod
Future<Iterable<Widget>> allTrackImages(AllTrackImagesRef ref) async {
  final track = ref.watch(trackSelectedProvider);
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  return trackNotifier.allTrackImages(track);
}

@riverpod
Future<Iterable<Widget>> allTrackImagesByTrack(
    AllTrackImagesByTrackRef ref, Track track, bool highQuality) async {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  return trackNotifier.allTrackImages(track);
}

@riverpod
Future<Map<Widget, String>> allTrackImagesWithPaths(
    AllTrackImagesWithPathsRef ref, Track track) async {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  return trackNotifier.allTrackImagesWithPaths(track);
}

@riverpod
Stream<Iterable<Comment>> fetchCommentsByTrackId(
    FetchCommentsByTrackIdRef ref, TrackId id) async* {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  yield* trackNotifier.fetchCommentsByTrackId(id);
}

@riverpod
Future<bool> openGoogleMap(OpenGoogleMapRef ref, Track track) async {
  final _trackNotifier = ref.watch(trackNotifierProvider.notifier);
  if (track != Track.empty())
    return await _trackNotifier.openGoogleMap(track);
  else
    return false;
}

@riverpod
Future<Iterable<Track>> fetchTracksByIds(FetchTracksByIdsRef ref,
    List<TrackId> favoriteTracks, BuildContext context) async {
  final trackNotifier = ref.watch(trackNotifierProvider.notifier);
  final tracks = await trackNotifier.fetchTracksByIds(favoriteTracks, context);
  return tracks;
}

//------------------NOTIFIER------------------//

//toggle for the view of services
@riverpod
class ToggleIconsServicesView extends _$ToggleIconsServicesView {
  @override
  bool build() {
    return false;
  }

  void toggle() {
    state = !state;
  }
}

@riverpod
class TrackSelected extends _$TrackSelected {
  @override
  Track build() {
    return Track.empty();
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
    yield* _trackRepository.fetchAllTracks();
  }

  //get tracks by region
  Stream<Iterable<Track>> fetchTracksByRegion(String region) async* {
    final AsyncValue<Iterable<Track>> asyncTracks =
        ref.watch(fetchAllTracksProvider);
    yield switch (asyncTracks) {
      AsyncData(:final value) => value.where((track) => track.region == region),
      _ => []
    };
  }

  Future<List<Widget>> fetchSelectedTracksThumbnail(List<Track> tracks) async {
    final List<Widget> images = [];
    for (final track in tracks) {
      final image = await trackThumbnail(track);
      images.add(image);
    }
    return images;
  }

  //collect track Thumbnail
  Future<Widget> trackThumbnail(Track track) async {
    try {
      final imageUrl = await _storageRepository
          .getDownloadUrl(track.photosUrl + MapConstans.thumbnail);
      final image = await Utils.getThumbnail(
          imageUrl); // Ensure this returns Future<Uint8List>
      return image;
    } catch (e) {
      return Image.asset(
        MapConstans.placeholder,
        fit: BoxFit.cover,
        scale: MapConstans.scaleImage,
      );
    }
  }

  Future<Iterable<Widget>> allTrackImages(Track track) async {
    //get all images inside the tracks/{track.region}/{track.trackWebCode}/
    if (track != Track.empty()) {
      final storageRegion = track.region.toLowerCase().replaceAll(' ', '_');
      final path = 'tracks/${storageRegion}/${track.id}/';
      final urls = await _storageRepository.listDownloadUrl(path);

      // Ensure Utils.getImage returns a Future<Widget>
      final images = await Future.wait(
          urls.map((url) => Future(() => Utils.getImage(url))));
      return images;
    } else {
      return [];
    }
  }

  Future<Iterable<String>> allPathsTrack(Track track) async {
    final storageRegion = track.region.toLowerCase().replaceAll(' ', '_');
    final directory = 'tracks/${storageRegion}/${track.id}/';
    return await _storageRepository.listPaths(directory);
  }

  Future<Map<Widget, String>> allTrackImagesWithPaths(Track track) async {
    final images = await allTrackImages(track);
    final paths = await allPathsTrack(track);
    return Map<Widget, String>.fromIterables(images, paths);
  }

  //add comment
  void addComment(
    BuildContext context,
    String text,
    TrackId id,
    double rating,
  ) async {
    final String commentId = Uuid().v1();
    final userId = ref.read(userIdProvider);
    final Comment comment = Comment(
      commentId: commentId,
      id: id,
      userId: userId,
      userName: FirebaseAuth.instance.currentUser!.displayName!,
      text: text,
      date: DateTime.now(),
      rating: rating,
    );
    final res = await _trackRepository.addComment(comment);
    final trackSelected = ref.read(trackSelectedProvider);
    final updatedTrack = trackSelected.copyWith(
      rating: _trackRepository.calculateNewRating(
        trackSelected.rating,
        trackSelected.commentCount,
        rating,
        true,
      ),
      commentCount: trackSelected.commentCount + 1,
    );
    await updateTrack(updatedTrack);
    Future.delayed(Duration(seconds: 1), () {
      ref.read(trackSelectedProvider.notifier).setTrack(updatedTrack);
    });

    res.fold((l) => Utils.showSnackBar(context, l.message),
        (r) => Utils.showSnackBar(context, 'Commento aggiunto con successo'));
  }

  //remove comment
  void removeComment(Comment comment, BuildContext context) async {
    final res = await _trackRepository.removeComment(comment);
    final trackSelected = ref.read(trackSelectedProvider);
    final updatedTrack = trackSelected.copyWith(
      rating: _trackRepository.calculateNewRating(
        trackSelected.rating,
        trackSelected.commentCount,
        comment.rating,
        false,
      ),
      commentCount: trackSelected.commentCount - 1,
    );
    await updateTrack(updatedTrack);
    ref.read(trackSelectedProvider.notifier).setTrack(updatedTrack);
    res.fold((l) => null,
        (r) => Utils.showSnackBar(context, 'Commento rimosso con successo'));
  }

  //get all comments related to a track
  Stream<Iterable<Comment>> fetchCommentsByTrackId(TrackId id) async* {
    yield* _trackRepository.fetchCommentsByTrackId(id);
  }

  Future<bool> openGoogleMap(Track track) async {
    final _url = Uri.parse(
        'https://www.google.com/maps/dir/?api=1&destination=' +
            track.latitude +
            ',' +
            track.longitude +
            '&travelmode=driving');

    return await launchUrl(_url);
  }

  //update track
  Future<void> updateTrack(Track newTrack) async {
    await _trackRepository.updateTrack(newTrack);
  }

  //fetch all tracks from a list of string ids
  Future<Iterable<Track>> fetchTracksByIds(
      Iterable<TrackId> ids, BuildContext context) async {
    final res = await _trackRepository.fetchTracksByIds(ids);
    return res.fold(
      (l) {
        Utils.showSnackBar(context, l.message);
        return [];
      },
      (r) => r,
    );
  }
}

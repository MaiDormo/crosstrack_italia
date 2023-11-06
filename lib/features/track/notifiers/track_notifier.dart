import 'dart:async';
import 'package:crosstrack_italia/features/map/providers/constants/constants.dart';
import 'package:crosstrack_italia/features/track/backend/track_repository.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/providers/storage_repository.dart';
import 'package:crosstrack_italia/views/components/tracks/providers/track_selected_provider.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

//------------------NOTIFIER------------------//
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
      final imageUrl =
          await _storageRepository.getDownloadUrl(track.photosUrl + thumbnail);
      final image = Image.network(
        imageUrl,
        width: 200,
        height: 100,
        fit: BoxFit.cover,
        scale: scaleImage,
      );
      state = true;

      ///TODO: remove print
      return image;
    } catch (e) {
      state = false;
      return Image.asset(
        placeholder,
        width: 200,
        height: 100,
        fit: BoxFit.cover,
        scale: scaleImage,
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
      controller.add(imagesList); //TODO: remove print
      state = true;
    } else {
      state = false;
      controller.add([]);
    }
    yield* controller.stream;
  }
}

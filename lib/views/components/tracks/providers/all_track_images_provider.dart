import 'dart:async';

import 'package:crosstrack_italia/features/track_info/models/track.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'all_track_images_provider.g.dart';

@riverpod
Stream<Iterable<Image>> allTrackImages(
    AllTrackImagesRef ref, Track? track) async* {
  final controller = StreamController<Iterable<Image>>();
  final storage = FirebaseStorage.instance;
  //get all images inside the tracks/{track.region}/{track.trackWebCode}/
  if (track != null) {
    final storageRegion = track.region.toLowerCase().replaceAll(' ', '_');
    final ref = storage.ref('tracks/${storageRegion}/${track.trackWebCode}/');
    final listResult = await ref.listAll();
    final images = listResult.items.map((e) => e.fullPath);
    final urls =
        await Future.wait(images.map((e) => storage.ref(e).getDownloadURL()));
    final imagesList = await urls.map((e) => Image.network(e));
    controller.add(imagesList);
  } else {
    controller.add([]);
  }
  yield* controller.stream;
}

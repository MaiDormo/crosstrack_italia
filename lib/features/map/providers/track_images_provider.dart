import 'package:crosstrack_italia/features/map/providers/constants/constants.dart';
import 'package:crosstrack_italia/features/track_info/models/track.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'track_images_provider.g.dart';

@riverpod
Future<Image> trackThumbnail(TrackThumbnailRef ref, Track track) async {
  try {
    final storage = firebase_storage.FirebaseStorage.instance;
    final ref = storage.ref(track.photosUrl + thumbnail);
    final imageUri = await ref.getDownloadURL();
    final image = Image.network(
      imageUri,
      width: 200,
      height: 100,
      fit: BoxFit.cover,
      scale: scaleImage,
    );

    return image;
  } catch (e) {
    return Image.asset(
      placeholder,
      width: 200,
      height: 100,
      fit: BoxFit.cover,
      scale: scaleImage,
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

@immutable
class Utils {
  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(text),
        ),
      );
  }

  // static Future<Uint8List> _getCompressedImage(
  //     String imageUrl, int minHeight, int minWidth) async {
  //   final ByteData imageData =
  //       await NetworkAssetBundle(Uri.parse(imageUrl)).load("");
  //   final Uint8List uint8list = imageData.buffer.asUint8List();
  //   final compressedData = await FlutterImageCompress.compressWithList(
  //     uint8list,
  //     minHeight: minHeight.h.floor(),
  //     minWidth: minWidth.w.floor(),
  //     quality: 85,
  //   );
  //   return compressedData;
  // }

  // static Future<Uint8List> getCompressedImage(String imageUrl) {
  //   return _getCompressedImage(imageUrl, 300, 400);
  // }

  // static Future<Uint8List> getCompressedThumbnail(String thumbnailUrl) {
  //   return _getCompressedImage(thumbnailUrl, 150, 200);
  // }

  static const thumbnailDimentions = const Size(150, 200);
  static const imageDimentions = const Size(300, 400);

  static Widget getImage(String imageUrl) {
    return SizedBox(
      height: imageDimentions.height.h,
      width: imageDimentions.width.w,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            buildSkeletonScreenAnimation(context, imageDimentions),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/placeholder.jpg',
          width: imageDimentions.width.w,
          height: imageDimentions.height.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget getThumbnail(String thumbnailUrl) {
    return SizedBox(
      height: thumbnailDimentions.height.h,
      width: thumbnailDimentions.width.w,
      child: CachedNetworkImage(
        imageUrl: thumbnailUrl,
        placeholder: (context, url) =>
            buildSkeletonScreenAnimation(context, thumbnailDimentions),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/placeholder.jpg',
          width: thumbnailDimentions.width.w,
          height: thumbnailDimentions.height.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget buildSkeletonScreenAnimation(
          BuildContext context, Size imageSize) =>
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4.0).w,
        child: Shimmer(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
              Theme.of(context).colorScheme.onSecondary,
            ],
            stops: const [0.0, 0.5, 1.0],
          ),
          child: Container(
            width: imageSize.width.w,
            height: imageSize.height.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
      );
}

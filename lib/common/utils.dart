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

  static final thumbnailDimentions = Size(150, 200);
  static final imageDimentions = Size(300, 400);

  static Widget getImage(String imageUrl) {
    return _buildImage(imageUrl, imageDimentions);
  }

  static Widget getThumbnail(String thumbnailUrl) {
    return _buildImage(thumbnailUrl, thumbnailDimentions);
  }

  static Widget _buildImage(String imageUrl, Size size) {
    return SizedBox(
      height: size.height.h,
      width: size.width.w,
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        placeholder: (context, url) =>
            buildSkeletonScreenAnimation(context, size),
        errorWidget: (context, url, error) => Image.asset(
          'assets/images/placeholder.jpg',
          width: size.width.w,
          height: size.height.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  static Widget buildSkeletonScreenAnimation(
          BuildContext context, Size imageSize) =>
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.0).w,
        child: Shimmer(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.onSecondary,
              Theme.of(context).colorScheme.onSecondary.withOpacity(0.5),
              Theme.of(context).colorScheme.onSecondary,
            ],
            stops: [0.0, 0.5, 1.0],
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

//------------------------BEFORE GRADLE PROBLEM------------------------

//This commented code was used to compress the images.
//It is not used anymore because importing the project in android studio,
//created a problem with gradle and the project was not compiling anymore.

//So i have decided to opt for a different solution, 
//using the cached_network_image package



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
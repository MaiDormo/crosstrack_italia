import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart';
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

  static const thumbnailDimentions = Size(150, 200);
  static const imageDimentions = Size(300, 400);

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
      child: kIsWeb
          ? _buildWebImage(imageUrl, size)
          : _buildCachedImage(imageUrl, size),
    );
  }

  /// Web-compatible image loading using Image.network
  static Widget _buildWebImage(String imageUrl, Size size) {
    return Image.network(
      imageUrl,
      width: size.width.w,
      height: size.height.h,
      fit: BoxFit.cover,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return buildSkeletonScreenAnimation(context, size);
      },
      errorBuilder: (context, error, stackTrace) {
        debugPrint('Image load error: $error');
        return Image.asset(
          'assets/images/placeholder.jpg',
          width: size.width.w,
          height: size.height.h,
          fit: BoxFit.cover,
        );
      },
    );
  }

  /// Mobile image loading with caching
  static Widget _buildCachedImage(String imageUrl, Size size) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      width: size.width.w,
      height: size.height.h,
      fit: BoxFit.cover,
      placeholder: (context, url) =>
          buildSkeletonScreenAnimation(context, size),
      errorWidget: (context, url, error) {
        debugPrint('CachedNetworkImage error: $error for URL: $url');
        return Image.asset(
          'assets/images/placeholder.jpg',
          width: size.width.w,
          height: size.height.h,
          fit: BoxFit.cover,
        );
      },
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
              Theme.of(context).colorScheme.onSecondary.withValues(alpha: 0.5),
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
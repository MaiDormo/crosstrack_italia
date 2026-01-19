import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';

Widget buildTrackImagesSwiper(
  AsyncValue<Iterable<Widget>> allTrackImages,
  BuildContext context,
) =>
    Consumer(
        builder: (context, ref, widget) => switch (allTrackImages) {
              AsyncData(:final value) => buildSwiper(value, context),
              AsyncError() => buildPlaceholderImage(),
              _ => buildSkeletonScreenAnimation(context),
            });

Widget buildSwiper(
  Iterable<Widget> images,
  BuildContext context,
) =>
    SizedBox(
      height: 300.h,
      width: 400.w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Swiper(
          curve: Curves.easeOut,
          layout: SwiperLayout.DEFAULT,
          itemCount: images.length,
          itemBuilder: (BuildContext context, int index) {
            return images.elementAt(index);
          },
          pagination: SwiperPagination(
            builder: SwiperPagination.dots,
          ),
          autoplay: true,
          autoplayDelay: 4000,
          autoplayDisableOnInteraction: true,
          plugins: const <SwiperPlugin>[
            SwiperPagination(),
            SwiperControl(),
          ],
        ),
      ),
    );

Widget buildPlaceholderImage() => Image.asset(
      'assets/images/placeholder.jpg',
      width: 150.w,
      height: 100.h,
      fit: BoxFit.cover,
    );

Widget buildSkeletonScreenAnimation(BuildContext context) {
  final colorScheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0).w,
    child: Shimmer(
      gradient: LinearGradient(
        colors: [
          colorScheme.surfaceContainerHighest,
          colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
          colorScheme.surfaceContainerHighest,
        ],
        stops: const [0.0, 0.5, 1.0],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Container(
          width: 400.w,
          height: 300.h,
          color: colorScheme.surface,
        ),
      ),
    ),
  );
}

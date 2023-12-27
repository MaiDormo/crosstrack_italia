import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackImagesSwiper(
  AsyncValue<Iterable<Image>> allTrackImages,
  BuildContext context,
) =>
    Consumer(
      builder: (context, ref, widget) => allTrackImages.when(
        data: (images) {
          return buildSwiper(images, context);
        },
        loading: () {
          return Center(child: const CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return buildPlaceholderImage();
        },
      ),
    );

Widget buildSwiper(
  Iterable<Image> images,
  BuildContext context,
) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 262.5.h,
        width: MediaQuery.of(context).size.width,
        child: Swiper(
          layout: SwiperLayout.DEFAULT,
          itemCount: images.length,
          itemWidth: MediaQuery.of(context).size.width,
          itemBuilder: (BuildContext context, int index) {
            return images.elementAt(index);
          },
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(bottom: 10.0).h,
            builder: SwiperPagination.dots,
          ),
          autoplay: true,
          autoplayDelay: 4000,
        ),
      ),
    );

Widget buildPlaceholderImage() {
  return Image.asset(
    'assets/images/placeholder.jpg',
    width: 150.w,
    height: 100.h,
    fit: BoxFit.cover,
  );
}

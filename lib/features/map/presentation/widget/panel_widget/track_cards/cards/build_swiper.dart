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
          return Center(
            child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.onSecondary),
          );
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
      padding: const EdgeInsets.symmetric(horizontal: 4.0).w,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: SizedBox(
          height: 300.h,
          width: 400.w,
          child: Swiper(
            curve: Curves.easeOut,
            layout: SwiperLayout.DEFAULT,
            itemCount: images.length,
            itemHeight: 300.h,
            itemWidth: 400.w,
            itemBuilder: (BuildContext context, int index) {
              return images.elementAt(index);
            },
            pagination: SwiperPagination(
              builder: SwiperPagination.dots,
            ),
            autoplay: true,
            autoplayDelay: 4000,
            plugins: const <SwiperPlugin>[
              SwiperPagination(),
              SwiperControl(),
            ],
          ),
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

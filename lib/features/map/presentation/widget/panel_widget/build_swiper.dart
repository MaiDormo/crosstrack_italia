import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildTrackImagesSwiper(AsyncValue<Iterable<Image>> allTrackImages,
        BuildContext context, double heightFactor) =>
    Consumer(
      builder: (context, ref, widget) => allTrackImages.when(
        data: (images) {
          return buildSwiper(images, context, heightFactor);
        },
        loading: () {
          return Center(child: const CircularProgressIndicator());
        },
        error: (error, stackTrace) {
          return buildPlaceholderImage(heightFactor);
        },
      ),
    );

Widget buildSwiper(
        Iterable<Image> images, BuildContext context, double heightFactor) =>
    Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 350 * heightFactor,
        width: MediaQuery.of(context).size.width,
        child: Swiper(
          layout: SwiperLayout.DEFAULT,
          itemCount: images.length,
          itemWidth: MediaQuery.of(context).size.width,
          itemBuilder: (BuildContext context, int index) {
            return images.elementAt(index);
          },
          pagination: SwiperPagination(
            margin: const EdgeInsets.only(bottom: 10.0),
            builder: SwiperPagination.dots,
          ),
          autoplay: true,
          autoplayDelay: 4000,
        ),
      ),
    );

Widget buildPlaceholderImage(double heightFactor) {
  return Image.asset(
    'assets/images/placeholder.jpg',
    width: 200 * heightFactor,
    height: 100,
    fit: BoxFit.cover,
  );
}

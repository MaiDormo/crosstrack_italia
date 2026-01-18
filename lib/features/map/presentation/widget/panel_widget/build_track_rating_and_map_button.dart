import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:crosstrack_italia/features/user_info/constants/user_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildTrackRatingAndMapButton(
  Track trackSelected,
  BuildContext context,
) =>
    Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildRatingRow(trackSelected, context),
              buildMapButton(trackSelected, context, ref),
            ],
          ),
          buildReviewCountText(trackSelected, context),
        ],
      ),
    );

Widget buildRatingRow(
  Track trackSelected,
  BuildContext context,
) =>
    Row(
      children: [
        Text(
          'Valutazione: ' + trackSelected.rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        RatingBarIndicator(
          physics: NeverScrollableScrollPhysics(),
          itemSize: 15.h,
          rating: trackSelected.rating,
          direction: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemPadding: const EdgeInsets.symmetric(horizontal: 4.0).w,
        ),
      ],
    );

Widget buildMapButton(
  Track trackSelected,
  BuildContext context,
  WidgetRef ref,
) =>
    Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) {
        return ElevatedButton(
          onPressed: () => ref
              .read(
                openGoogleMapProvider(trackSelected),
              )
              .when(
                data: (value) => showSnackBar(
                    context,
                    value,
                    'Apertura Google Maps in corso',
                    'Google Maps non disponibile'),
                loading: () {
                  final snackBar =
                      SnackBar(content: Text('Apertura Google Maps in corso'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                error: (error, stackTrace) {
                  final snackBar =
                      SnackBar(content: Text('Google Maps non disponibile'));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Colors.white,
            ),
            foregroundColor: WidgetStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.symmetric(
                vertical: 4.h, // Use ScreenUtil to set height
                horizontal: 5.w, // Use ScreenUtil to set width
              ),
            ),
          ),
          child: Row(
            children: [
              Visibility(
                visible: ref.watch(userSettingsProvider)[
                    UserConstants.showMoreInfo]!, // Use ScreenUtil to set p),
                child: Text(
                  'Indicazioni',
                  style: TextStyle(
                      fontSize: 12.sp), // Use ScreenUtil to set font size
                ),
              ),
              SizedBox(width: 3.w), // Use ScreenUtil to set width
              Icon(Icons.directions,
                  size: 24.sp), // Use ScreenUtil to set icon size
            ],
          ),
        );
      },
    );

Widget buildReviewCountText(
  Track trackSelected,
  BuildContext context,
) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0).w,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            'Recensioni: ' + trackSelected.commentCount.toString(),
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        ],
      ),
    );

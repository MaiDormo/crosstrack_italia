import 'package:crosstrack_italia/features/map/presentation/widget/panel_widget/utilities.dart';
import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/notifiers/track_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Widget buildTrackRatingAndMapButton(
        Track trackSelected, BuildContext context, double heightFactor) =>
    Consumer(
      builder: (BuildContext context, WidgetRef ref, Widget? child) => Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              buildRatingRow(trackSelected, context, heightFactor),
              buildMapButton(trackSelected, context, heightFactor, ref),
            ],
          ),
          buildReviewCountText(trackSelected, context, heightFactor),
        ],
      ),
    );

Widget buildRatingRow(
        Track trackSelected, BuildContext context, double heightFactor) =>
    Row(
      children: [
        Text(
          'Valutazione: ' + trackSelected.rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 16 * heightFactor,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        RatingBarIndicator(
          physics: NeverScrollableScrollPhysics(),
          itemSize: 20 * heightFactor,
          rating: trackSelected.rating,
          direction: Axis.horizontal,
          itemCount: 5,
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: Theme.of(context).colorScheme.primary,
          ),
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
        ),
      ],
    );

Widget buildMapButton(Track trackSelected, BuildContext context,
        double heightFactor, WidgetRef ref) =>
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
            backgroundColor: MaterialStateProperty.all(
              Theme.of(context).colorScheme.secondary,
            ),
          ),
          child: Row(
            children: [
              Text('Indicazioni'),
              SizedBox(width: 4 * heightFactor),
              Icon(Icons.directions),
            ],
          ),
        );
      },
    );

Widget buildReviewCountText(
        Track trackSelected, BuildContext context, double heightFactor) =>
    Text(
      'Recensioni: ' + trackSelected.commentCount.toString(),
      style: TextStyle(
        fontSize: 16 * heightFactor,
        fontWeight: FontWeight.bold,
        color: Theme.of(context).colorScheme.primary,
      ),
    );

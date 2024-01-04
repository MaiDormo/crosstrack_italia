import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher_string.dart';

Widget buildMotoclubCard(
  Track selectedTrack,
  BuildContext context,
) =>
    Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(
                '${selectedTrack.motoclub}',
                style: TextStyle(
                  fontSize: 11.25.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
              ),
              3.verticalSpace,
              GestureDetector(
                onTap: () async {
                  if (selectedTrack.website.isEmpty) {
                    //show snackbar
                    SnackBar(
                      content: Text('Nessun sito web disponibile'),
                    );
                  }

                  try {
                    bool launched =
                        await launchUrlString(selectedTrack.website);

                    if (!launched) {
                      SnackBar(
                        content: Text('Impossibile aprire il sito web'),
                      );
                    }
                  } catch (e) {
                    SnackBar(
                      content: Text('Errore inaspettato'),
                    );
                  }
                },
                child: Icon(
                  Icons.travel_explore_rounded,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 37.5.h,
                ),
              ),
            ],
          ),
        ),
      ),
    );

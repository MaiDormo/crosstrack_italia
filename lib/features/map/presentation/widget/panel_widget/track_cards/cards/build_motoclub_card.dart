import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/user_info/constants/user_constants.dart';
import 'package:crosstrack_italia/features/user_info/notifiers/user_settings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
          padding: EdgeInsets.all(8.0).r,
          child: Column(
            children: [
              Text(
                'Motoclub',
                style: TextStyle(
                  fontSize: 11.25.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              3.verticalSpace,
              Text(
                '${selectedTrack.motoclub}',
                style: TextStyle(
                  fontSize: 11.25.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
                textAlign: TextAlign.center,
              ),
              3.verticalSpace,
              GestureDetector(
                onTap: () async {
                  if (selectedTrack.website.isEmpty) {
                    //show snackbar
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Nessun sito web disponibile'),
                      ),
                    );
                  } else {
                    try {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Apertura sito web...'),
                        ),
                      );

                      bool launched =
                          await launchUrlString(selectedTrack.website);

                      Future.delayed(Duration(seconds: 1), () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      });

                      if (!launched) {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content:
                                Text('Sito non apribile, riprova più tardi'),
                          ),
                        );
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Errore nell\'apertura del sito web'),
                        ),
                      );
                    }
                  }
                },
                child: Card(
                  color: Theme.of(context).colorScheme.onSecondary,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.travel_explore_rounded,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 37.5.h,
                    ),
                  ),
                ),
              ),
              3.verticalSpace,
              Consumer(
                builder: (context, ref, child) {
                  final showMoreInfo = ref
                      .watch(userSettingsProvider)[UserConstants.showMoreInfo]!;

                  return Visibility(
                    visible: showMoreInfo,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Premere per maggiori informazioni',
                        style: TextStyle(
                          fontSize: 9.sp,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );

import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:crosstrack_italia/features/track/models/typedefs/typedefs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPilotInfoCard(
  Track trackSelected,
  BuildContext context,
) =>
    Expanded(
      child: Card(
        color: Theme.of(context).colorScheme.secondary,
        child: Padding(
          padding: EdgeInsets.all(8.0).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //title
              Text(
                'Info pilota',
                style: TextStyle(
                  fontSize: 11.25.sp,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.tertiary,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.badge_outlined,
                    color: Theme.of(context).colorScheme.onSecondary,
                  ),
                  3.75.verticalSpace,
                  Column(
                    children: [
                      ...trackSelected.acceptedLicenses
                          .map(
                            (license) => switch (license) {
                              TrackLicense.fmi => buildLicenseCard(
                                  TrackLicense.fmi,
                                  context,
                                ),
                              TrackLicense.uisp => buildLicenseCard(
                                  TrackLicense.uisp,
                                  context,
                                ),
                              TrackLicense.asi => buildLicenseCard(
                                  TrackLicense.asi,
                                  context,
                                ),
                              TrackLicense.csen => buildLicenseCard(
                                  TrackLicense.csen,
                                  context,
                                ),
                              TrackLicense.asc => buildLicenseCard(
                                  TrackLicense.csen,
                                  context,
                                ),
                              TrackLicense.aics => buildLicenseCard(
                                  TrackLicense.aics,
                                  context,
                                ),
                            },
                          )
                          .toList(),
                      3.75.verticalSpace,
                    ],
                  ),
                ],
              ),

              //minicross
              buildMinicrossRow(
                  'Minicross:', trackSelected.hasMinicross, context),
            ],
          ),
        ),
      ),
    );

Widget buildLicenseCard(
  TrackLicense license,
  BuildContext context,
) =>
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0.w,
        vertical: 4.0.h,
      ),
      child: Row(
        children: [
          Image.asset(
            'assets/images/license_img/logo-${license.toString().split('.').last}.jpg',
            height: 35.7.h,
            width: 35.7.w,
          ),
          3.75.horizontalSpace,
          Text(license.toString().split('.').last),
        ],
      ),
    );

Widget buildMinicrossRow(
  String label,
  String value,
  BuildContext context,
) =>
    Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.25.sp,
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.tertiary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0.w, vertical: 4.0.h),
          child: switch (value) {
            'si' => Icon(
                Icons.check,
                color: Colors.greenAccent,
              ),
            'no' => Icon(
                Icons.close,
                color: Colors.redAccent,
              ),
            _ => Container(),
          },
        ),
      ],
    );

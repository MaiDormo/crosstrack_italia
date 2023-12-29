import 'package:crosstrack_italia/features/track/models/track.dart';
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
                              'fmi' => buildLicenseCard(
                                  'fmi',
                                  'assets/images/license_img/logo-fmi.jpg',
                                  context),
                              'uisp' => buildLicenseCard(
                                  'uisp',
                                  'assets/images/license_img/logo-uisp.jpg',
                                  context),
                              'asi' => buildLicenseCard(
                                  'asi',
                                  'assets/images/license_img/logo-asi.jpg',
                                  context),
                              'csen' => buildLicenseCard(
                                  'csen',
                                  'assets/images/license_img/logo-csen.jpg',
                                  context),
                              'asc' => buildLicenseCard(
                                  'asc',
                                  'assets/images/license_img/logo-asc.jpg',
                                  context),
                              _ => Container(),
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
  String license,
  String imagePath,
  BuildContext context,
) =>
    Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 8.0.w,
        vertical: 4.0.h,
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Image.asset(
              imagePath,
              height: 35.7.h,
              width: 35.7.w,
            ),
          ),
          3.75.horizontalSpace,
          Text(license),
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

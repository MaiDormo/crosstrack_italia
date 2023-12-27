import 'package:crosstrack_italia/features/track/models/track.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildPilotInfoCard(
  Track trackSelected,
  BuildContext context,
) =>
    Expanded(
      child: Card(
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
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.badge_outlined,
                  ),
                  3.75.verticalSpace,
                  Column(
                    children: [
                      ...trackSelected.acceptedLicenses
                          .map(
                            (license) => switch (license) {
                              'fmi' => buildLicenseCard('fmi',
                                  'assets/images/license_img/logo-fmi.jpg'),
                              'uisp' => buildLicenseCard('uisp',
                                  'assets/images/license_img/logo-uisp.jpg'),
                              'asi' => buildLicenseCard('asi',
                                  'assets/images/license_img/logo-asi.jpg'),
                              'csen' => buildLicenseCard('csen',
                                  'assets/images/license_img/logo-csen.jpg'),
                              'asc' => buildLicenseCard('asc',
                                  'assets/images/license_img/logo-asc.jpg'),
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
              buildMinicrossRow('Minicross:', trackSelected.hasMinicross),
            ],
          ),
        ),
      ),
    );

Widget buildLicenseCard(String license, String imagePath) => Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 8.0,
          vertical: 4.0,
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
      ),
    );

Widget buildMinicrossRow(
  String label,
  String value,
) =>
    Row(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11.25.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Card(
          child: Padding(
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
        ),
      ],
    );
